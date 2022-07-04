//
//  APIPostService.swift
//  ZemogaTechTest
//
//  Created by macbook  on 30/6/22.
//

import Foundation
import Alamofire

class APIPostService: PostService{
    func getAllPosts(completion: @escaping (ServiceResponseStatus<[Post]>) -> ()) {
        
        let encoding = JSONEncoding.default
        AF.request(Endpoints.post.url, method: .get, encoding: encoding).responseDecodable(of: [Post].self) { (response) in
            switch response.result{
            case .success:
                if response.response!.statusCode >= 200 && response.response!.statusCode <= 299{
                    completion(.success(response.value ?? []))
                }else{
                    completion(.failure(response.error?.localizedDescription ?? "Not found"))
                }
            case .failure:
                completion(.failure(response.error?.localizedDescription ?? ""))
            }
            
        }
    }
    
    func getCommentsInPost(postId: Int, completion: @escaping (ServiceResponseStatus<[Comment]>) -> ()) {
        let encoding = JSONEncoding.default
        AF.request(Endpoints.comment(postId: postId).url, method: .get, encoding: encoding).responseDecodable(of: [Comment].self) { (response) in
            switch response.result{
            case .success:
                if response.response!.statusCode >= 200 && response.response!.statusCode <= 299{
                    completion(.success(response.value ?? []))
                }else{
                    completion(.failure(response.error?.localizedDescription ?? "Not found"))
                }
            case .failure:
                completion(.failure(response.error?.localizedDescription ?? ""))
            }
            
        }
    }
    
    func getUserInPost(userId: Int, completion: @escaping (ServiceResponseStatus<[User]>) -> ()) {
        let encoding = JSONEncoding.default
        AF.request(Endpoints.user(userId: userId).url, method: .get, encoding: encoding).responseDecodable(of: [User].self) { (response) in
            switch response.result{
            case .success:
                if response.response!.statusCode >= 200 && response.response!.statusCode <= 299{
                    guard let value = response.value else {return}
                    completion(.success(value))
                }else{
                    completion(.failure(response.error?.localizedDescription ?? "Not found"))
                }
            case .failure:
                completion(.failure(response.error?.localizedDescription ?? ""))
            }
            
        }
    }
}
