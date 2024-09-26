//
//  NetworkManager.swift
//  Solid Principle
//
//  Created by Kumar Basant on 10/07/24.
//

import Foundation
enum ApiError:Error{
    case badUrl
    case InvalidJson
    case NoData
}
class NetworkManager{
    var apiObj:ApiHandlerderDelegate
    var responseObj:responseHandlerlegate
    init(apiObj: ApiHandlerderDelegate = ApiHandler(), responseObj: responseHandlerlegate = responseHandler()) {
        self.apiObj = apiObj
        self.responseObj = responseObj
    }
    func fetchRequest<T:Codable>(type:T.Type,url:URL,completion:@escaping (Result<T,ApiError>)->()){
        apiObj.fetchData(url: url) { result in
            switch result {
            case .success(let data):
                self.responseObj.fetchModel(type: T.self, data: data) { result in
                    switch result {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    func fetchAsyncRequset<T:Codable>(type:T.Type,url:URL) async throws -> T{
       let data = try await apiObj.fetchDataUsingAsync(url: url)
        let model = try await responseObj.fetchModelUsingAsync(type: T.self, data: data)
        return model 
    }
}
protocol ApiHandlerderDelegate{
    func fetchData(url:URL,completion:@escaping (Result<Data,ApiError>)->())
    func fetchDataUsingAsync(url:URL) async throws -> Data
}
class ApiHandler:ApiHandlerderDelegate{
    func fetchDataUsingAsync(url:URL) async throws -> Data {
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
            throw ApiError.NoData
        }
        return data
    }
    
    func fetchData(url:URL,completion:@escaping (Result<Data,ApiError>)->()){
        let urlrequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlrequest) { data, res, error in
            guard let data = data, error == nil else {return completion(.failure(ApiError.badUrl))}
            completion(.success(data))
        }.resume()
    }
}
protocol responseHandlerlegate{
    func fetchModel<T:Codable>(type:T.Type,data:Data,completion:@escaping (Result<T,ApiError>)->())
    func fetchModelUsingAsync<T:Codable>(type:T.Type,data:Data) async throws ->T
}
class responseHandler:responseHandlerlegate{
    func fetchModelUsingAsync<T:Codable>(type:T.Type,data:Data) async throws -> T {
        do{
            let model =  try JSONDecoder().decode(type.self, from: data)
            return model
        }catch{
           throw ApiError.InvalidJson
        }
    }
    
    func fetchModel<T:Codable>(type:T.Type,data:Data,completion:(Result<T,ApiError>)->()){
        do{
           
            let model =  try JSONDecoder().decode(type.self, from: data)
            completion(.success(model))
        }catch{
            completion(.failure(ApiError.InvalidJson))
        }
    }
}
