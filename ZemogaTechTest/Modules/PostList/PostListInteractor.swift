//
//  PostListInteractor.swift
//  ZemogaTechTest
//
//  Created by macbook  on 30/6/22.
//

import Foundation

/** Interactor of the PostList Module set*/
final class PostListInteractor:PostListInteractorProtocol{
   
    //Bussiness logic goes here
    
    weak var output: PostListInteractorOutputProtocol!
    let postService = APIPostService()
    let coreDataService = APICoreDataService()
    
    required init(){}
    
    func getAllPosts() {
        postService.getAllPosts {[weak self] response in
            guard let self = self else {return}
            switch response{
            case let .success(model):
                self.output.success(model)
            case let .failure(error):
                self.output.error(error)
            }
        }
    }
    
    func checkIfCDIsEmpty() -> Int {
        return coreDataService.retrieve(Post.self).count
    }
    
    func getAllCDPosts(){
        let model = coreDataService.retrieve(Post.self, order: .init(key: "isFavorite", ascending: false))
        output.success(model)
    }
    
    func uploadAllPosts(posts: [Post]) {
        coreDataService.create(posts)
        output.success()
        
    }
    
    func filterFavoritePosts(mode: Int){
        if mode == 0{
            let model = coreDataService.retrieve(Post.self, order: .init(key: "isFavorite", ascending: false))
            output.success(model)
            
        }else{
            let model = coreDataService.retrieve(Post.self, order: .init(key: "id", ascending: true), predicate: NSPredicate(format: "isFavorite == true"))
            output.success(model)
        }
    }
    
    func deleteAllPosts(){
        coreDataService.deleteAll(Post.self)
        output.successDelete()
        
    }
    
    deinit {
        print("PostList Interactor Destroyed")
    }
}

