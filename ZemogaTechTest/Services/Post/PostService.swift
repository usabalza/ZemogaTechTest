//
//  PostService.swift
//  ZemogaTechTest
//
//  Created by macbook  on 30/6/22.
//

import Foundation

protocol PostService{
    func getAllPosts(completion: @escaping (ServiceResponseStatus<[Post]>) -> ())
    func getCommentsInPost(postId: Int, completion: @escaping (ServiceResponseStatus<[Comment]>) -> ())
    func getUserInPost(userId: Int, completion: @escaping (ServiceResponseStatus<[User]>) -> ())
}
