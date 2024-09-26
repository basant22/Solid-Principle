//
//  MockCommentViewService.swift
//  Solid PrincipleTests
//
//  Created by Kumar Basant on 17/07/24.
//

import Foundation
@testable import Solid_Principle
class MockCommentViewService:CommentViewServiceDelegate{
    var result:Result<[Solid_Principle.Comments], Solid_Principle.ApiError>!
    func getAllComments(completion: @escaping (Result<[Solid_Principle.Comments], Solid_Principle.ApiError>) -> Void) {
        completion(result)
    }
    
    func getAllCommentsAsync() async throws -> [Solid_Principle.Comments] {
        return []
    }
    func comments()->[Solid_Principle.Comments]?{
        do{
        guard let fileurl = Bundle.main.url(forResource: "comments", withExtension: "json") else {return nil}
        let data = try Data(contentsOf: fileurl)
        let model = try JSONDecoder().decode([Solid_Principle.Comments].self, from: data)
            return model
        }catch{
            return nil
        }
    }
    
}
