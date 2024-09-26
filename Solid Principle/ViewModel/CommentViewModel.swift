//
//  CommentViewModel.swift
//  Solid Principle
//
//  Created by Kumar Basant on 11/07/24.
//

import Foundation
@MainActor
class CommentViewModel:ObservableObject{
    var apiService:CombinedCommentAndUsers
    var dbSevices:CommentViewServiceDelegate
    @Published var comments:[Comments] = []
    @Published var isLoading:Bool = false
    var workItem:DispatchWorkItem?
    init(apiService: CombinedCommentAndUsers = CommentViewService(), dbSevices: CommentViewServiceDelegate = DatabaseHandler() ) {
        self.apiService = apiService
        self.dbSevices = dbSevices
    }
    func getCommentsAsync() async {
        if isInternt(){
            self.isLoading = true
            do{
                let model = try await apiService.getAllCommentsAsync()
                self.isLoading = false
                self.comments = model
            }catch{
                
            }
        }else{
            do{
                self.isLoading = true
                let model = try await dbSevices.getAllCommentsAsync()
                self.isLoading = false
                self.comments = model
            }catch{
                
            }
        }
    }
    func getComments(){
        DispatchQueue.main.async{
            self.isLoading = true
        }
        if isInternt(){
            apiService.getAllComments { result in
                switch result {
                case .success(let model):
                    DispatchQueue.main.async{
                        self.isLoading = false
                        self.comments = model
                    }
                case .failure:
                    DispatchQueue.main.async{
                        self.isLoading = false
                    }
                }
            }
        }else{
            dbSevices.getAllComments{ result in
                switch result {
                case .success(let model):
                    DispatchQueue.main.async{
                        self.isLoading = false
                        self.comments = model
                    }
                case .failure:
                    DispatchQueue.main.async{
                        self.isLoading = false
                    }
                }
            }
        }
    }
    func getAllUsers(){
        DispatchQueue.main.async{
            self.isLoading = true
        }
        apiService.getAllusers { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.async{
                    self.isLoading = false
                }
            case .failure(let failure):
                DispatchQueue.main.async{
                    self.isLoading = false
                }
            }
        }
    }
    func isInternt()->Bool{
        return false
    }
}
