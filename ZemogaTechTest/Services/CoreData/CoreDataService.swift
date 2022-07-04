//
//  CoreDataService.swift
//  ZemogaTechTest
//
//  Created by macbook  on 3/7/22.
//

import Foundation
import CoreData

enum StateCore: Int, Codable{
    case none
    case created
    case deleted
    case edited
    case copy
}
protocol ModelCoreData{
    var stateCore: StateCore?{get set}
    static func getEntity() -> String
    func getCoreDataDictionary() -> [String:Any?]
    func getIdentifier() -> Int
    init(object: NSManagedObject)
}
protocol CoreDataService{
    func create        <T:ModelCoreData>(_ model: T, save: Bool)
    func createLocal   <T:ModelCoreData>(_ model: T, save: Bool)
    func create        <T:ModelCoreData>(_ models: [T])
    func retrieve      <T:ModelCoreData>(_ clase: T.Type, order: NSSortDescriptor?, predicate: NSPredicate?) -> [T]
    func retrieve      <T:ModelCoreData>(id: Int,clase: T.Type) -> T?
    func retrieve      <T:ModelCoreData>(query: String,id: String,clase: T.Type) -> [T]
    func checkIfExist  <T:ModelCoreData>(_ model: T) -> Bool
    func update        <T:ModelCoreData>(_ model: T, save: Bool)
    func delete        <T:ModelCoreData>(_ model: T)
    func delete        <T:ModelCoreData>(id: Int,clase: T.Type)
    func delete        <T:ModelCoreData>(query: String, id: String,clase: T.Type)
    func deleteAll     <T:ModelCoreData>(_ clase: T.Type)
}
extension CoreDataService{
    func retrieve      <T:ModelCoreData>(_ clase: T.Type, order: NSSortDescriptor? = nil, predicate: NSPredicate? = nil) -> [T]{
        return self.retrieve(clase, order: order, predicate: predicate)
    }
    func create<T:ModelCoreData>(_ model: T, save: Bool = false){
        self.create(model, save: save)
    }
    func update<T:ModelCoreData>(_ model: T, save: Bool = false){
        self.update(model, save: save)
    }
}
