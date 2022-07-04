//
//  PostDetailView.swift
//  ZemogaTechTest
//
//  Created by macbook  on 30/6/22.
//

import Foundation
import UIKit

/** View of the PostDetail Module set, UIKit Dependent*/
final class PostDetailView: UIViewController{

    internal var presenter: PostDetailPresenterProtocol!
    
    // - MARK: - IBOutlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    // - MARK: - Class Overriden Functions
    
    required convenience init() {
        self.init(nibName: "PostDetailView", bundle: nil)
        self.navigationItem.title = "Post"
        /*let starIcon = UIImage.init(systemName: "star")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: starIcon, style: .plain, target: self, action: #selector(addToFavorites))*/
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Code goes here
        
        loadTable()
        setNavBarStar(isFilled: presenter.getFavoriteStatus())
        presenter.viewDidLoad()
    }
    
    func loadTable(){
        tableView.register(UINib.init(nibName: CommentCell.identifier, bundle: nil), forCellReuseIdentifier: CommentCell.identifier)
        tableView.register(UINib.init(nibName: DescriptionCell.identifier, bundle: nil), forCellReuseIdentifier: DescriptionCell.identifier)
        tableView.register(UINib.init(nibName: UserCell.identifier, bundle: nil), forCellReuseIdentifier: UserCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    @objc func addToFavorites(){
        presenter.addToFavorites()
        
    }
    
    @objc func deletePost(){
        let alert = UIAlertController(title: "Warning", message: "Are you sure to delete the current post?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            self.presenter.deletePost()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    deinit {
        print("PostDetail View Destroyed")
    }
    
    // - MARK: - IBActions and User's Interaction
    
    
}


extension PostDetailView:PostDetailViewProtocol{
    
    // - MARK: - GUI's animation and setup
    func reload() {
        tableView.reloadData()
    }
    
    func setNavBarStar(isFilled: Bool) {
        let starIcon = isFilled ? UIImage.init(systemName: "star.fill") : UIImage.init(systemName: "star")
        let starIconButton = UIBarButtonItem.init(image: starIcon, style: .plain, target: self, action: #selector(addToFavorites))
        starIconButton.tintColor = isFilled ? .systemYellow : .white
        let trashIcon = UIImage.init(systemName: "trash")
        let trashBinButton = UIBarButtonItem.init(image: trashIcon, style: .plain, target: self, action: #selector(deletePost))
        self.navigationItem.rightBarButtonItems = [starIconButton, trashBinButton]
    }
    
    func showLoading() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideLoading() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func alertVC(title: String?, message: String?, completion: (() -> ())?){
        let alert = UIAlertController(title: title ?? "", message: message ?? "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: completion)
    }
    
    func alertVCWithOKBlock(title: String?, message: String?){
        let alert = UIAlertController(title: title ?? "", message: message ?? "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.goBack()
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func goBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // - MARK:  -Data reciever
    
    
}

extension PostDetailView: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0, 1: return 1
        case 2: return presenter.getCommentCount()
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section{
        case 0: return "Description"
        case 1: return "User"
        case 2: return "Comments"
        default: return "Not specified"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.identifier, for: indexPath) as! DescriptionCell
            cell.setup(model: presenter.getPostDescription())
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: UserCell.identifier, for: indexPath) as! UserCell
            cell.setup(model: presenter.getPostUser())
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.identifier, for: indexPath) as! CommentCell
            cell.setup(model: presenter.getCommentIn(row: indexPath.row))
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionCell.identifier, for: indexPath) as! DescriptionCell
            return cell
        }
    }
}
