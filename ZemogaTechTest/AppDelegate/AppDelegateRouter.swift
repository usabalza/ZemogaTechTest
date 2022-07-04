//
//  AppDelegateRouter.swift
//  NursingCare
//
//  Created by wams macbook ios on 8/5/21.
//  Copyright © 2021 Shokworks Inc. All rights reserved.
//

import Foundation
import UIKit

/** Router of the AppDelegate Module set, UIKit Dependent*/
final class AppDelegateRouter:ViperRouterUIKit,AppDelegateRouterProtocol{
    func route(to r: AppDelegateRoutes){
        go { (current) -> (UIViewController) in
            switch r{
            case .list:
                return UINavigationController.init(rootViewController: PostListModule().default())
            }
        }
    }
}
