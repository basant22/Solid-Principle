//
//  NetworkRequest.swift
//  Solid Principle
//
//  Created by Kumar Basant on 13/08/24.
//

import Foundation
import Network
enum MyUrl:String{
    case jsonUsers = "https://jsonplaceholder.typicode.com/users"
    case githubUsers = "https://api.github.com/users"
}
protocol NetworkRequestDelegate{
    func fetchData<T:Codable>(type:T.Type,request:URLRequest) async throws -> T
}
class NetworkRequest:NetworkRequestDelegate{
    func fetchData<T:Codable>(type:T.Type,request:URLRequest) async throws -> T{
        
        let (data,response) = try await URLSession.shared.data(for: request)
        guard let response = response as? HTTPURLResponse,response.statusCode != 200 else {throw ApiError.InvalidJson}
        do{
            let model = try JSONDecoder().decode(type.self, from: data)
            return model
        }catch{
            throw ApiError.InvalidJson
        }
    }
}
