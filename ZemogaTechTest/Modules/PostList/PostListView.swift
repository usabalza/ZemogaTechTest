//
//  PostListView.swift
//  ZemogaTechTest
//
//  Created by macbook  on 30/6/22.
//

import Foundation
import UIKit

/** View of the PostList Module set, UIKit Dependent*/
final class PostListView: UIViewController{

    internal var presenter: PostListPresenterProtocol!
    var selectedMode: Int = 0
    
    // - MARK: - IBOutlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var postSelector: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    // - MARK: - Class Overriden Functions
    
    required convenience init() {
        self.init(nibName: "PostListView", bundle: nil)
        self.navigationItem.title = "Posts"
        self.navigationItem.backButtonTitle = ""
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .refresh, target: self, action: #selector(refreshContent))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Code goes here
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .blue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        print("Hello World")
        
        loadTable()
        presenter.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter.loadContent()
    }
    
    func loadTable(){
        tableView.register(UINib.init(nibName: PostCell.identifier, bundle: nil), forCellReuseIdentifier: PostCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @objc func refreshContent(){
        presenter.loadFromAPI()
    }
    
    deinit {
        print("PostList View Destroyed")
    }
    
    // - MARK: - IBActions and User's Interaction
    
    @IBAction func deleteAll(_ sender: UIButton) {
        let alert = UIAlertController(title: "Warning", message: "Are you sure to delete all posts?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            self.presenter.deleteAllPosts()
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func selectTableMode(_ sender: UISegmentedControl) {
        presenter.selectTableMode(mode: sender.selectedSegmentIndex)
        reload()
    }
    
}


extension PostListView:PostListViewProtocol{
    
    // - MARK: - GUI's animation and setup
    func showLoading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func alertVC(title: String?, message: String?) {
        let alert = UIAlertController(title: title ?? "", message: message ?? "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // - MARK:  -Data reciever
    func reload(){
        tableView.reloadData()
    }
    
    
}

extension PostListView: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getPostCount()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Number of posts: \(presenter.getPostCount())"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as! PostCell
        cell.setupFromAPI(model: presenter.getPostIn(row: indexPath.row))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.goToPostDetail(row: indexPath.row)
    }
}
