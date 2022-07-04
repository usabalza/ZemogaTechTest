//
//  PostDetailInteractor.swift
//  ZemogaTechTest
//
//  Created by macbook  on 30/6/22.
//

import Foundation

/** Interactor of the PostDetail Module set*/
final class PostDetailInteractor:PostDetailInteractorProtocol{
    //Bussiness logic goes here
    
    weak var output: PostDetailInteractorOutputProtocol!
    let postService = APIPostService()
    let coreDataService = APICoreDataService()
    
    required init(){}
    
    func getAllCommentsInPost(postId: Int) {
        postService.getCommentsInPost(postId: postId) {[weak self] response in
            guard let self = self else {return}
            switch response{
            case let .success(model):
                self.output.success(model)
            case let .failure(error):
                self.output.error(error)
            }
        }
    }
    
    func getUserInPost(userId: Int) {
        postService.getUserInPost(userId: userId) {[weak self] response in
            guard let self = self else {return}
            switch response{
            case let .success(model):
                self.output.success(model)
            case let .failure(error):
                self.output.error(error)
            }
        }
    }
    
    func addToFavorites(post: Post) {
        let updatedPost = post
        if updatedPost.isFavorite == false || updatedPost.isFavorite == nil{
            updatedPost.isFavorite = true
        }else{
            updatedPost.isFavorite = false
        }
        coreDataService.update(updatedPost, save: true)
        output.success(isFavorite: updatedPost.isFavorite!)
    }
    
    func deletePost(postId: Int) {
        coreDataService.delete(id: postId, clase: Post.self)
        output.successDelete()
    }
    
    deinit {
        print("PostDetail Interactor Destroyed")
    }
}

