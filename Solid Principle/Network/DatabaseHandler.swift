//
//  DatabaseHandler.swift
//  Solid Principle
//
//  Created by Kumar Basant on 10/07/24.
//

import Foundation
class DatabaseHandler:CommentViewServiceDelegate{
    func getAllCommentsAsync() async throws -> [Comments] {
        guard let url = Bundle.main.url(forResource: "comments", withExtension: "json"), let data = try? Data(contentsOf: url), let model = try? JSONDecoder().decode([Comments].self, from: data) else {
            throw ApiError.InvalidJson
        }
       return model
    }
    
    func getAllComments(completion: @escaping (Result<[Comments], ApiError>) -> Void) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm EEE, dd MMM y"
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .formatted(formatter)
        guard let url = Bundle.main.url(forResource: "comments", withExtension: "json"), let data = try? Data(contentsOf: url), let model = try? decoder.decode([Comments].self, from: data) else {
           return completion(.failure(ApiError.InvalidJson))
        }
        completion(.success(model))
    }
    
}
