//
//  PostListBuilder.swift
//  ZemogaTechTest
//
//  Created by macbook  on 30/6/22.
//

import Foundation
import UIKit

protocol PostListModuleInterface:AnyObject{
    func `default`()->UIViewController
}

final class PostListModule: ViperModuleBuilder<PostListView,PostListPresenter,PostListInteractor,PostListRouter>,PostListModuleInterface{
    public override class func identifier()->String{
        return "PostListModule"
    }
    
    func `default`() -> UIViewController {
        return object.imp.view
    }
    
    deinit {
        print("PostList Builder Destroyed")
    }
    
}
