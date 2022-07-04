//
//  PostListPresenter.swift
//  ZemogaTechTest
//
//  Created by macbook  on 30/6/22.
//

import Foundation


/** Presenter of the PostList Module set*/
final class PostListPresenter:PostListPresenterProtocol{
    
    internal weak var view: PostListViewProtocol!
    internal var router: PostListRouterProtocol!
    internal var interactor: PostListInteractorProtocol!
    
    var cachedTable = false
    var postArray: [Post] = []
    var reloadingFromAPI: Bool = false
    
    // - MARK: - View's Interactions
    func viewDidLoad(){
        
    }
    
    func loadContent(){
        view.showLoading()
        if interactor.checkIfCDIsEmpty() == 0{
            interactor.getAllPosts()
        }else{
            interactor.getAllCDPosts()
        }
    }
    
    func loadFromAPI(){
        reloadingFromAPI = true
        view.showLoading()
        print("Loading from API")
        interactor.reloadFromAPI()
    }
    
    func loadFromCoreData(){
        view.showLoading()
        print("Loading from CoreData")
        interactor.getAllCDPosts()
    }
    
    func goToPostDetail(row: Int) {
        router.route(to: .postDetail(post: postArray[row]))
    }
    
    func getPostCount() -> Int {
        return postArray.count
    }
    
    func getPostIn(row: Int) -> Post {
        return postArray[row]
    }
    
    func deleteAllPosts() {
        interactor.deleteAllPosts()
    }
    
    func selectTableMode(mode: Int) {
        interactor.filterFavoritePosts(mode: mode)
    }
    
    deinit {
        print("PostList Presenter Destroyed")
    }
}

extension PostListPresenter:PostListInteractorOutputProtocol{
    // MARK: - Interactor's Responses
    
    func successFetch(_ model: [Post]) {
        postArray = model
        if interactor.checkIfCDIsEmpty() != postArray.count{
            interactor.uploadAllPosts(posts: postArray)
        }
        print("\(model.count) entries loaded.")
        
        if reloadingFromAPI{
            reloadingFromAPI = false
            interactor.getAllCDPosts()
        }else{
            self.view.hideLoading()
            self.view.reload()
        }
    }
    
    func successDelete() {
        postArray = []
        view.reload()
        view.alertVC(title: "Data deleted", message: "All posts was deleted successfully.")
    }
    
    func successCD() {
        print("Uploaded to CD")
        view.hideLoading()
        view.reload()
    }
    
    func error(_ message: String) {
        view.hideLoading()
        view.alertVC(title: "Error", message: message)
    }
}
