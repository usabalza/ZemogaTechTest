//
//  ViperUIModuleProtocol.swift
//  NursingCare
//
//  Created by Uziel Sabalza on 8/4/21.
//  Copyright © 2021 Shokworks Inc. All rights reserved.
//

import Foundation
import UIKit

typealias WeakViewController = WeakContainer<UIViewController>
class ViperRouterUIKit:ViperRouter{
    
    static var window: UIWindow?
    static var vcs:[String:WeakViewController] = [:]
    private weak var current:UIViewController?
    
    func set(module:ViperModuleProtocol){
        current = module.view as? UIViewController
        ViperRouterUIKit.vcs[module.identifier] = WeakViewController.init(value: current!)
    }
    
    required init(){}

    internal func go(to nextModule: (UIViewController?)->(UIViewController)){
        let vc = nextModule(current)
        if ViperRouterUIKit.window == nil{
            ViperRouterUIKit.window = UIWindow(frame: UIScreen.main.bounds)
            ViperRouterUIKit.window?.rootViewController = vc
            ViperRouterUIKit.window?.makeKeyAndVisible()
        }
    }
}
struct WeakContainer<T>where T: AnyObject {
    weak var _value : T?
    
    init (value: T) {
        _value = value
    }
    
    func get() -> T? {
        return _value
    }
}


