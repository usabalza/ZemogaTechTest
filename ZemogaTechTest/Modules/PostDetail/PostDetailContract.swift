//
//  PostDetailContract.swift
//  ZemogaTechTest
//
//  Created by macbook  on 30/6/22.
//

import Foundation

// - MARK: - Contract

protocol PostDetailViewProtocol:ViperView{
    var presenter: PostDetailPresenterProtocol!{get set}
    func showLoading()
    func hideLoading()
    func setNavBarStar(isFilled: Bool)
    func reload()
    func alertVC(title: String?, message: String?, completion: (() -> ())?)
    func alertVCWithOKBlock(title: String?, message: String?)
    func goBack()
}

protocol PostDetailPresenterProtocol:ViperPresenter{
    var view:PostDetailViewProtocol!{get set}
    var router: PostDetailRouterProtocol!{set get}
    var interactor: PostDetailInteractorProtocol!{set get}

    func viewDidLoad()
    func loadContent()
    func getFavoriteStatus() -> Bool
    func getPostDescription() -> String?
    func getPostUser() -> User?
    func getCommentCount() -> Int
    func getCommentIn(row: Int) -> Comment
    func addToFavorites()
    func deletePost()
}

protocol PostDetailInteractorProtocol:ViperInteractor{
    var output: PostDetailInteractorOutputProtocol!{get set}
    func addToFavorites(post: Post)
    func getAllCommentsInPost(postId: Int)
    func getUserInPost(userId: Int)
    func deletePost(postId: Int)
    
}

protocol PostDetailInteractorOutputProtocol:AnyObject{
    func success(_ model: [Comment])
    func success(_ model: [User])
    func successDelete()
    func success(isFavorite: Bool)
    func error(_ message: String)
}

protocol PostDetailRouterProtocol:AnyObject{
    func route(to:PostDetailRoutes)
}

// - MARK: - Contract Enums

enum PostDetailRoutes{
    
}


//DONT TOUCH THESE PLEASE

extension PostDetailViewProtocol{
    func set(_ presenter: ViperPresenter) {
        self.presenter = presenter as? PostDetailPresenterProtocol
    }
}

extension PostDetailPresenterProtocol{
    func set(_ view:ViperView){
        self.view = view as? PostDetailViewProtocol
    }
    func set(_ router:ViperRouter){
        self.router = router as? PostDetailRouterProtocol
    }
    func set(_ interactor:ViperInteractor){
        self.interactor = interactor as? PostDetailInteractorProtocol
    }
}

extension PostDetailInteractorProtocol{
    func set(_ output:ViperPresenter){
        self.output = output as? PostDetailInteractorOutputProtocol
    }
}

