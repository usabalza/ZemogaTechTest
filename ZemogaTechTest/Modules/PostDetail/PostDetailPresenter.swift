//
//  PostDetailPresenter.swift
//  ZemogaTechTest
//
//  Created by macbook  on 30/6/22.
//

import Foundation
import UIKit


/** Presenter of the PostDetail Module set*/
final class PostDetailPresenter:PostDetailPresenterProtocol{
    
    internal weak var view: PostDetailViewProtocol!
    internal var router: PostDetailRouterProtocol!
    internal var interactor: PostDetailInteractorProtocol!
    
    var selectedPost: Post?
    var postUser: User?
    var commentArray: [Comment] = []
    private let manager = CoreDataManager()
    
    // - MARK: - View's Interactions
    func viewDidLoad(){
        loadContent()
    }
    
    func loadContent() {
        view.showLoading()
        guard let id = selectedPost?.id else {return}
        interactor.getAllCommentsInPost(postId: id)
    }
    
    func getFavoriteStatus() -> Bool{
        return selectedPost?.isFavorite ?? false
    }
    
    func getPostDescription() -> String?{
        return selectedPost?.body
    }
    
    func getPostUser() -> User?{
        return postUser
    }
    
    func getCommentCount() -> Int{
        return commentArray.count
    }
    
    func getCommentIn(row: Int) -> Comment{
        return commentArray[row]
    }
    
    func addToFavorites() {
        guard let post = selectedPost else {return}
        interactor.addToFavorites(post: post)
    }
    
    func deletePost() {
        guard let id = selectedPost?.id else {return}
        interactor.deletePost(postId: id)
    }
    
    deinit {
        print("PostDetail Presenter Destroyed")
    }
}

extension PostDetailPresenter:PostDetailInteractorOutputProtocol{
    
    // MARK: - Interactor's Responses
    func successComment(_ model: [Comment]) {
        guard let userId = selectedPost?.userId else {return}
        commentArray = model
        interactor.getUserInPost(userId: userId)
    }
    
    func successFavorite(_ isFavorite: Bool){
        view.setNavBarStar(isFilled: isFavorite)
        let message = isFavorite ? "Post added to favorites." : "Post removed from favorites."
        view.alertVC(title: "Success", message: message)
    }
    
    func successUser(_ model: [User]) {
        view.hideLoading()
        postUser = model[0]
        view.reload()
    }
    
    func successDelete() {
        view.alertVCWithOKBlock(title: "Success", message: "Post was deleted successfully.")
    }
    
    
    func error(_ message: String) {
        view.hideLoading()
        view.alertVC(title: "Error", message: message)
        return
    }
}
