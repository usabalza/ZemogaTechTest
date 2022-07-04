//
//  PostDetailRouter.swift
//  ZemogaTechTest
//
//  Created by macbook  on 30/6/22.
//

import Foundation
import UIKit

/** Router of the PostDetail Module set, UIKit Dependent*/
final class  PostDetailRouter:ViperRouterUIKit,PostDetailRouterProtocol{
    ///Routes to other viper modules defined in `PostDetailRoutes`
    func route(to r: PostDetailRoutes) {
        
    }
    
    deinit {
        print("PostDetail Router Destroyed")
    }
}
