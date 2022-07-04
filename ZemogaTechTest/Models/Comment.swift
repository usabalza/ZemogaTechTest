//
//  Comment.swift
//  ZemogaTechTest
//
//  Created by macbook  on 30/6/22.
//

import Foundation

struct Comment: Codable{
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
