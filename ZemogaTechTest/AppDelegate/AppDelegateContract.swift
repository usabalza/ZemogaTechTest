//
//  AppDelegateContract.swift
//  NursingCare
//
//  Created by wams macbook ios on 8/5/21.
//  Copyright © 2021 Shokworks Inc. All rights reserved.
//

import Foundation

// - MARK: Contract

protocol AppDelegateInteractorProtocol{
    var output: AppDelegateInteractorOutputProtocol? {get set}
}

protocol AppDelegateRouterProtocol{
    mutating func route(to:AppDelegateRoutes)
}

protocol AppDelegateInteractorOutputProtocol:AnyObject{

}

// - MARK: Contract Enums
enum AppDelegateRoutes{
    case list
}

