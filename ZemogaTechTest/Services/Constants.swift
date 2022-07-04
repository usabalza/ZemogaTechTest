//
//  Constants.swift
//  ZemogaTechTest
//
//  Created by macbook  on 30/6/22.
//

import Foundation

// MARK: - Base URL
let API_BASE_URL = "https://jsonplaceholder.typicode.com/"

enum Endpoints{
    
    case post
    case comment(postId: Int)
    case user(userId: Int)
    
    private var fullPath: String{
        var endpoint: String
        
        switch self{
        case .post:
            endpoint = "posts"
        case .comment(let postId):
            endpoint = "comments?postId=\(postId)"
        case .user(let userId):
            endpoint = "users?id=\(userId)"
        }
        return API_BASE_URL + endpoint
    }
    
    var url: URL {
        guard let url = URL(string: fullPath) else {
            preconditionFailure("The url used in \(Endpoints.self) is not valid")
        }
        return url
    }
}

enum ServiceResponseStatus<T>{
    case success(_ model: T)
    case failure(_ msg: String)
}
