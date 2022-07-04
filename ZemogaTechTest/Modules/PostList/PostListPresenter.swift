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
    //var cdPostArray: [CDPost] = []
    //private let manager = CoreDataManager()
    
    
    // - MARK: - View's Interactions
    func viewDidLoad(){
        //view.showLoading()
        /*cdPostArray = manager.fetchPosts()
        if cdPostArray.count == 0{
            print("Data empty. Populating...")
            loadContent()
        }else{
            cachedTable = true
            view.hideLoading()
            print("Loading from cache CoreData")
            view.reload()
        }*/
        
        //loadContent()
        
    }
    
    func loadContent(){
        view.showLoading()
        if interactor.checkIfCDIsEmpty() == 0{
            print("Loaded from API")
            interactor.getAllPosts()
        }else{
            print("Loaded from CoreData")
            interactor.getAllCDPosts()
        }
        
    }
    
    func goToPostDetail(row: Int) {
        router.route(to: .postDetail(post: postArray[row]))
    }
    
    func getPostCount() -> Int {
        return postArray.count
    }
    
    /*func getCDPostCount() -> Int{
        return cdPostArray.count
    }*/
    
    func getPostIn(row: Int) -> Post {
        return postArray[row]
    }
    
    /*func getCDPostIn(row: Int) -> CDPost {
        return cdPostArray[row]
    }*/
    
    func hasCache() -> Bool {
        return cachedTable
    }
    
    func deleteAllPosts() {
        interactor.deleteAllPosts()
    }
    
    
    
    func selectTableMode(mode: Int) {
        interactor.filterFavoritePosts(mode: mode)
    }
    
    func loadFromCoreData() {
        //cdPostArray = manager.fetchPosts()
        view.reload()
    }
    
    deinit {
        print("PostList Presenter Destroyed")
    }
}

extension PostListPresenter:PostListInteractorOutputProtocol{
    // MARK: - Interactor's Responses
    
    func success(_ model: [Post]) {
        postArray = model
        if interactor.checkIfCDIsEmpty() == 0{
            interactor.uploadAllPosts(posts: postArray)
        }
        print("\(model.count) entries loaded.")
        self.view.hideLoading()
        self.view.reload()
    }
    
    func successDelete() {
        postArray = []
        view.reload()
        view.alertVC(title: "Data deleted", message: "All posts was deleted successfully.")
    }
    
    func success() {
        print("Uploaded to CD")
        view.reload()
    }
    
    func error(_ message: String) {
        view.hideLoading()
        view.alertVC(title: "Error", message: message)
    }
}
