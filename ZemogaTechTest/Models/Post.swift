//
//  Post.swift
//  ZemogaTechTest
//
//  Created by macbook  on 30/6/22.
//

import Foundation
import CoreData

/*struct Post: Codable{
 
 let userId: Int
 let id: Int
 let title: String
 let body: String
 
 }
 
 public class CDPost: NSManagedObject{
 @NSManaged var userId: Int16
 @NSManaged var id: Int16
 @NSManaged var title: String
 @NSManaged var body: String
 @NSManaged var isFavorite: Bool
 
 }*/

class Post: NSObject, Codable, NSSecureCoding, ModelCoreData{
    public static var supportsSecureCoding: Bool {
        return true
    }
    var stateCore: StateCore?
    var userId: Int
    var id: Int
    var title: String
    var body: String
    var isFavorite: Bool? = false
    
    static func getEntity() -> String {
        return Entitys.post.rawValue
        
    }
    
    func getCoreDataDictionary() -> [String : Any?] {
        return [
            "userId": self.userId,
            "id": self.id,
            "title": self.title,
            "body": self.body,
            "isFavorite": self.isFavorite
            
        ]
    }
    
    func getIdentifier() -> Int {
        return self.id
    }
    
    required init(object: NSManagedObject) {
        self.userId = object.value(forKey: "userId") as! Int
        self.id = object.value(forKey: "id") as! Int
        self.title = object.value(forKey: "title") as! String
        self.body = object.value(forKey: "body") as! String
        self.isFavorite = object.value(forKey: "isFavorite") as? Bool
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(userId, forKey: "userId")
        coder.encode(id, forKey: "id")
        coder.encode(title, forKey: "title")
        coder.encode(body, forKey: "body")
        coder.encode(isFavorite, forKey: "isFavorite")
    }
    
    required public init?(coder: NSCoder) {
        self.userId = coder.decodeInteger(forKey: "userId")
        self.id = coder.decodeInteger(forKey: "id")
        self.title = coder.decodeObject(forKey: "title") as! String
        self.body = coder.decodeObject(forKey: "body") as! String
        self.isFavorite = coder.decodeBool(forKey: "isFavorite")
    }
    
}
