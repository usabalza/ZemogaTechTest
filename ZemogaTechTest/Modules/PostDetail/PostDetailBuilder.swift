//
//  PostDetailBuilder.swift
//  ZemogaTechTest
//
//  Created by macbook  on 30/6/22.
//

import Foundation
import UIKit

protocol PostDetailModuleInterface:AnyObject{
    func custom(post: Post)->UIViewController
}

final class PostDetailModule: ViperModuleBuilder<PostDetailView,PostDetailPresenter,PostDetailInteractor,PostDetailRouter>,PostDetailModuleInterface{
    public override class func identifier()->String{
        return "PostDetailModule"
    }
    
    func custom(post: Post) -> UIViewController {
        object.imp.presenter.selectedPost = post
        return object.imp.view
    }
    
    deinit {
        print("PostDetail Builder Destroyed")
    }
    
}
