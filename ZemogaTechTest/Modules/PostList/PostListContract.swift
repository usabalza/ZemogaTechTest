//
//  PostListContract.swift
//  ZemogaTechTest
//
//  Created by macbook  on 30/6/22.
//

import Foundation

// - MARK: - Contract

protocol PostListViewProtocol:ViperView{
    var presenter: PostListPresenterProtocol!{get set}
    func showLoading()
    func hideLoading()
    func alertVC(title: String?, message: String?)
    func reload()
}

protocol PostListPresenterProtocol:ViperPresenter{
    var view:PostListViewProtocol!{get set}
    var router: PostListRouterProtocol!{set get}
    var interactor: PostListInteractorProtocol!{set get}

    func viewDidLoad()
    func loadFromCoreData()
    func hasCache() -> Bool
    func loadContent()
    func getPostCount() -> Int
    func getPostIn(row: Int) -> Post
    //func getCDPostCount() -> Int
    //func getCDPostIn(row: Int) -> CDPost
    func goToPostDetail(row: Int)
    func selectTableMode(mode: Int)
    func deleteAllPosts()
}

protocol PostListInteractorProtocol:ViperInteractor{
    var output: PostListInteractorOutputProtocol!{get set}
    func getAllPosts()
    func getAllCDPosts()
    func uploadAllPosts(posts: [Post])
    func filterFavoritePosts(mode: Int)
    func checkIfCDIsEmpty() -> Int
    func deleteAllPosts()
}

protocol PostListInteractorOutputProtocol:AnyObject{
    func success(_ model: [Post])
    //func successCD(_ model: [Post])
    func success()
    func successDelete()
    func error(_ message: String)
}

protocol PostListRouterProtocol:AnyObject{
    func route(to:PostListRoutes)
}

// - MARK: - Contract Enums

enum PostListRoutes{
    case postDetail(post: Post)
}


//DONT TOUCH THESE PLEASE

extension PostListViewProtocol{
    func set(_ presenter: ViperPresenter) {
        self.presenter = presenter as? PostListPresenterProtocol
    }
}

extension PostListPresenterProtocol{
    func set(_ view:ViperView){
        self.view = view as? PostListViewProtocol
    }
    func set(_ router:ViperRouter){
        self.router = router as? PostListRouterProtocol
    }
    func set(_ interactor:ViperInteractor){
        self.interactor = interactor as? PostListInteractorProtocol
    }
}

extension PostListInteractorProtocol{
    func set(_ output:ViperPresenter){
        self.output = output as? PostListInteractorOutputProtocol
    }
}

