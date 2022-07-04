//
//  PostListRouter.swift
//  ZemogaTechTest
//
//  Created by macbook  on 30/6/22.
//

import Foundation
import UIKit

/** Router of the PostList Module set, UIKit Dependent*/
final class  PostListRouter:ViperRouterUIKit,PostListRouterProtocol{
    ///Routes to other viper modules defined in `PostListRoutes`
    func route(to r: PostListRoutes) {
        go { (current) -> (UIViewController) in
            switch r{
            case let .postDetail(post):
                let vc = PostDetailModule().custom(post: post)
                current?.navigationController?.pushViewController(vc, animated: true)
            }
            return .init()
        }
    }
    
    deinit {
        print("PostList Router Destroyed")
    }
}
