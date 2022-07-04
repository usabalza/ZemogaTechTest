//
//  CoreDataManager.swift
//  ZemogaTechTest
//
//  Created by macbook  on 2/7/22.
//

import Foundation
import CoreData

class CoreDataManager{
    
    private static var container: NSPersistentContainer!
    
    init() {
        CoreDataManager.container = NSPersistentContainer(name: "ZemogaTechTest")
        setupDatabase()
    }
    
    private func setupDatabase() {
        CoreDataManager.container.loadPersistentStores { (desc, error) in
            if let error = error {
                print("Error loading store \(desc) — \(error)")
                return
            }
            print("Database ready!")
            
        }
    }
    
    /*func savePost(post: Post, completion: @escaping() -> Void){
        let context = CoreDataManager.container.viewContext
        let cdPost = CDPost(context: context)
        cdPost.userId = Int16(post.userId)
        cdPost.id = Int16(post.id)
        cdPost.title = post.title
        cdPost.body = post.body
        
        do {
            try context.save()
            print("Post \(post.title) guardado")
            completion()
            
        } catch {
            
            print("Error guardando usuario — \(error)")
        }
    }*/
    
    /*func newBatchInsertRequest(posts: [Post]) -> NSBatchInsertRequest{
        var index = 0
        let total = posts.count
        
        let batchInsert = NSBatchInsertRequest(entity: CDPost.entity()) { (managedObject: NSManagedObject) -> Bool in
            guard index < total else {return true}
            if let post = managedObject as? CDPost {
                let data = posts[index]
                post.userId = Int16(data.userId)
                post.id = Int16(data.id)
                post.title = data.title
                post.body = data.body
                post.isFavorite = false
            }
            
            index += 1
            return false
        }
        return batchInsert
    }*/
    
    /*func batchInsertPosts(posts: [Post], completion: @escaping() -> Void){
        guard !posts.isEmpty else {return}
        CoreDataManager.container.performBackgroundTask { context in
            let batchInsert = self.newBatchInsertRequest(posts: posts)
            do{
                try context.execute(batchInsert)
                completion()
            }catch{
                print("Batch Failure")
            }
        }
    }*/
    
    /*func deletePost(post: Post, completion: @escaping() -> Void){
        let context = CoreDataManager.container.viewContext
        let cdPost = CDPost(context: context)
        cdPost.userId = Int16(post.userId)
        cdPost.id = Int16(post.id)
        cdPost.title = post.title
        cdPost.body = post.body
        
        context.delete(cdPost)
        do {
            try context.save()
            print("Post \(post.title) borrado")
            completion()
            
        } catch {
            print("Error borrando usuario — \(error)")
        }
    }*/
    
    /*func fetchPosts() -> [CDPost] {
        let context = CoreDataManager.container.viewContext
        let fetchRequest : NSFetchRequest<CDPost> = CDPost.fetchRequest() as! NSFetchRequest<CDPost>
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "CDPost", in: context)
        do {
            
            let result = try CoreDataManager.container.viewContext.fetch(fetchRequest)
            return result
            
        } catch {
            print("El error obteniendo posts(s) \(error)")
            
        }
        
        return []
    }*/
    
    /*func fetchPostsWithFilter() -> [CDPost] {
        let fetchRequest : NSFetchRequest<CDPost> = CDPost.fetchRequest() as! NSFetchRequest<CDPost>
        fetchRequest.predicate = NSPredicate(format: "isFavorite = true")
        do {
            
            let result = try CoreDataManager.container.viewContext.fetch(fetchRequest)
            return result
            
        } catch {
            print("El error obteniendo posts(s) \(error)")
            
        }
        return []
    }*/
    
    /*func addFavorite(id: Int) -> Bool{
        let context = CoreDataManager.container.viewContext
        var boolean: Bool?
        let fetchRequest : NSFetchRequest<CDPost> = CDPost.fetchRequest() as! NSFetchRequest<CDPost>
        fetchRequest.entity = NSEntityDescription.entity(forEntityName: "CDPost", in: context)
        fetchRequest.predicate = NSPredicate(format: "id = \(id)")
        
        do{
            let object = try context.fetch(fetchRequest)
            if object.count == 1{
                let updated = object.first!
                boolean = !updated.isFavorite
                updated.setValue(boolean, forKey: "isFavorite")
                do{
                    try context.save()
                }
                catch{
                    print(error)
                }
            }
        }catch{
            print(error)
        }
        return boolean ?? false
    }*/
    
    /*func deleteAllPosts(){
        let context = CoreDataManager.container.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CDPost")

        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.execute(batchDeleteRequest)
        } catch {
            
        }

    }*/
}
