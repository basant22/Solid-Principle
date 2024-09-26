//
//  CommentRequest.swift
//  Solid Principle
//
//  Created by Kumar Basant on 10/07/24.
//

import Foundation
enum ApiType:String{
    case comments = "https://jsonplaceholder.typicode.com/comments"
    case allUers = "https://jsonplaceholder.typicode.com/users"
    case openlibrary = "https://openlibrary.org.com/search.json?title="
}
protocol CombinedCommentAndUsers:CommentViewServiceDelegate,userDelegate{
    
}
protocol userDelegate{
    func getAllusers(completion:@escaping (Result<Users,ApiError>)->Void)
}
protocol CommentViewServiceDelegate{
    func getAllComments(completion:@escaping (Result<[Comments],ApiError>)->Void)
    func getAllCommentsAsync() async throws -> [Comments]
}
class CommentViewService:CombinedCommentAndUsers{
    func getAllCommentsAsync() async throws -> [Comments] {
        guard let url = URL(string: ApiType.comments.rawValue) else {throw ApiError.badUrl}
        let model = try await NetworkManager().fetchAsyncRequset(type: [Comments].self, url: url)
        return model
    }
    
    func getAllComments(completion:@escaping (Result<[Comments],ApiError>)->Void){
        guard let url = URL(string: ApiType.comments.rawValue) else {return completion(.failure(ApiError.badUrl))}
        NetworkManager().fetchRequest(type: [Comments].self, url: url, completion: completion)
    }
    
    func getAllusers(completion:@escaping (Result<Users,ApiError>)->Void){
        guard let url = URL(string: ApiType.comments.rawValue) else {return completion(.failure(ApiError.badUrl))}
        NetworkManager().fetchRequest(type: Users.self, url: url, completion: completion)
    }
}
