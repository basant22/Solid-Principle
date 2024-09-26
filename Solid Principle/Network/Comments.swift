//
//  Comments.swift
//  Solid Principle
//
//  Created by Kumar Basant on 10/07/24.
//

import Foundation
struct Comments:Codable,Identifiable{
    var postId:Int
    var id:Int
    var name:String
    var email:String
    var body:String
    var commentCreated:Date?
    enum CodingKeys: String,CodingKey {
        case postId
        case id
        case name
        case email
        case body
        case commentCreated = "formated"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.postId = try container.decode(Int.self, forKey: .postId)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? "N/A"
        self.email = try container.decode(String.self, forKey: .email)
        self.body = try container.decode(String.self, forKey: .body)
        self.commentCreated = try container.decodeIfPresent(Date.self, forKey: .commentCreated) ?? nil
    }
}
struct Users:Codable,Identifiable{
    var postId:MyIdType
    var id:Int
    var name:String
    var email:String
    var body:String
    enum CodingKeys: CodingKey {
        case postId
        case id
        case name
        case email
        case body
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.postId = try container.decode(MyIdType.self, forKey: .postId)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.email = try container.decode(String.self, forKey: .email)
        self.body = try container.decode(String.self, forKey: .body)
    }
}

enum MyIdType:Codable{
    case int(Int)
    case string(String)
    
    init(from decoder: Decoder) throws {
        if let intValue = try? decoder.singleValueContainer().decode(Int.self){
            self = .int(intValue)
        }
        if let stringValue = try? decoder.singleValueContainer().decode(String.self){
            self = .string(stringValue)
        }
        throw MyIdTypeError.missingValue
    }
    enum MyIdTypeError:Error{
        case missingValue
    }
}
