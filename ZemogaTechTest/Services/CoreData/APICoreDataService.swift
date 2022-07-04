//
//  APICoreDataService.swift
//  ZemogaTechTest
//
//  Created by macbook  on 3/7/22.
//

import UIKit
import CoreData

enum Entitys: String{
    case post = "Post"
}
class APICoreDataService: CoreDataService {
    
    
    func create<T:ModelCoreData>(_ model: T, save: Bool = false){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let entity = NSEntityDescription.entity(forEntityName: type(of: model).getEntity(), in: managedContext)!
        
        //final, we need to add some data to our newly created record for each keys using
        let dic = model.getCoreDataDictionary()
        let keys = Array.init(dic.keys)
        let model = NSManagedObject(entity: entity, insertInto: managedContext)
        
        for k in keys{
            if dic[k]! != nil{
                model.setValue(dic[k]!, forKey: k)
            }
        }
        //Now we have set all the values. The next step is to save them inside the Core Data
        if !save{
            return
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func createLocal<T:ModelCoreData>(_ model: T, save: Bool = false){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let entity = NSEntityDescription.entity(forEntityName: type(of: model).getEntity(), in: managedContext)!
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: type(of: model).getEntity())
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "id", ascending: true)]
        //final, we need to add some data to our newly created record for each keys using
        var id = -1
        do{
            let result = try managedContext.fetch(fetchRequest)
            if result.count > 0{
                let tid = ((result[0] as! NSManagedObject).value(forKey: "id") as! Int)
                id = tid >= 0 ? -1 : tid - 1
            }
            
        } catch {
            print("FAILED SAVING")
            return
        }
        
        let dic = model.getCoreDataDictionary()
        let keys = Array.init(dic.keys)
        let model = NSManagedObject(entity: entity, insertInto: managedContext)
        
        for k in keys{
            if dic[k]! != nil{
                model.setValue(dic[k]!, forKey: k)
            }
        }
        model.setValue(id, forKey: "id")
        //Now we have set all the values. The next step is to save them inside the Core Data
        if !save{
            return
        }
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func create<T:ModelCoreData>(_ models: [T]){
        for (i,m) in models.enumerated(){
            if !checkIfExist(m){
                if i == (models.count - 1){
                    create(m, save: true)
                    return
                }
                create(m, save: false)
            }else{
                if i == (models.count - 1){
                    update(m, save: true)
                    return
                }
                update(m, save: false)
            }
            
        }
    }
    
    func retrieve<T:ModelCoreData>(_ clase: T.Type, order: NSSortDescriptor? = nil, predicate: NSPredicate? = nil) -> [T]{
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: clase.getEntity())
        if let order = order{
            fetchRequest.sortDescriptors = [order]
        }
        if let predicate = predicate{
            fetchRequest.predicate = predicate
        }
        do {
            let result = try managedContext.fetch(fetchRequest)
            var list:[T] = []
            for data in result as! [NSManagedObject] {
                list.append(clase.init(object: data))
            }
            return list
        } catch {
            print("Failed")
        }
        return []
    }
    
    func retrieve<T:ModelCoreData>(id: Int,clase: T.Type) -> T?{
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: clase.getEntity())
        fetchRequest.predicate = NSPredicate(format: "id = %d", id)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            if result.count > 0{
                return clase.init(object: result[0] as! NSManagedObject)
            }
        } catch {
            print("Failed")
        }
        return nil
    }
    
    func retrieve<T:ModelCoreData>(query: String, id: String,clase: T.Type) -> [T]{
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
    
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: clase.getEntity())
        fetchRequest.predicate = NSPredicate(format: "\(query) = %@", id)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            var list:[T] = []
            for data in result as! [NSManagedObject] {
                list.append(clase.init(object: data))
            }
            return list
        } catch {
            print("Failed")
        }
        return []
    }
    
    func checkIfExist<T:ModelCoreData>(_ model: T) -> Bool{
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Prepare the request of type NSFetchRequest  for the entity
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: type(of: model).getEntity())
        fetchRequest.predicate = NSPredicate(format: "id = %d", model.getIdentifier())
        
        do {
            let result = try managedContext.count(for: fetchRequest)
            if result > 0{
                return true
            }
            
        } catch {
            print("Failed")
        }
        return false
    }
    
    
    func update<T: ModelCoreData>(_ model: T, save: Bool = false){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: type(of: model).getEntity())
        fetchRequest.predicate = NSPredicate(format: "id = %d", model.getIdentifier())
        do{
            let test = try managedContext.fetch(fetchRequest)
            if test.count == 0{
                return
            }
            let objectUpdate = test[0] as! NSManagedObject
            let dic = model.getCoreDataDictionary()
            let keys = Array.init(dic.keys)
            for k in keys{
                if dic[k]! != nil{
                    objectUpdate.setValue(dic[k]!, forKey: k)
                }
            }
            if !save{
                return
            }
            do{
                try managedContext.save()
            }catch{
                print(error)
            }
        }catch{
            print(error)
        }
        
    }
    
    
    
    func delete<T: ModelCoreData>(_ model: T){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: type(of: model).getEntity())
        fetchRequest.predicate = NSPredicate(format: "id = %d", model.getIdentifier())
        do{
            let test = try managedContext.fetch(fetchRequest)
            
            if test.count > 0{
                let objectToDelete = test[0] as! NSManagedObject
                managedContext.delete(objectToDelete)
            }
            
            do{
                try managedContext.save()
            }catch{
                print(error)
            }
        }catch{
            print(error)
        }
    }
    
    
    
    func delete<T: ModelCoreData>(id: Int, clase : T.Type){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: clase.getEntity())
        fetchRequest.predicate = NSPredicate(format: "id = %d", id)
        
        do{
            let test = try managedContext.fetch(fetchRequest)
            if test.count > 0{
                let objectToDelete = test[0] as! NSManagedObject
                managedContext.delete(objectToDelete)
            }
            
            do{
                try managedContext.save()
            }catch{
                print(error)
            }
        }catch{
            print(error)
        }
    }
    
    func delete<T: ModelCoreData>(query: String, id: String, clase : T.Type){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: clase.getEntity())
        fetchRequest.predicate = NSPredicate(format: "\(query) = %@", id)
        
        do{
            let test = try managedContext.fetch(fetchRequest)
            for t in test{
                let objectToDelete = t as! NSManagedObject
                managedContext.delete(objectToDelete)
            }
            
            do{
                try managedContext.save()
            }catch{
                print(error)
            }
        }catch{
            print(error)
        }
    }
    
    
    func deleteAll<T:ModelCoreData>(_ clase: T.Type) {
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: clase.getEntity())
        
        do{
            let results = try managedContext.fetch(fetchRequest)
            for r in results{
                let objectToDelete = r as! NSManagedObject
                managedContext.delete(objectToDelete)
            }
            do{
                try managedContext.save()
            }catch{
                print(error)
            }
        }catch{
            print(error)
        }
    }
    
    
    
    
    
}
