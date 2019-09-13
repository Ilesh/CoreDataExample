//
//  PersistanceManager.swift
//  CoreDataDemo
//
//  Created by Ilesh's 2018 on 06/09/19.
//  Copyright © 2019 Ilesh's. All rights reserved.
//

import UIKit
import CoreData

final class PersistanceManager : NSObject {
    static let moduleName = "CoreData_Storage"

     ////  1
    static let shared = PersistanceManager()
   
    private override init(){
    }
    
    lazy var managedObjectModel : NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: PersistanceManager.moduleName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }   ()
    
    lazy var applicaitonDocumentDirectory = {
       return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
    }()
    
    
    lazy var persistentStoreCoordinator : NSPersistentStoreCoordinator = {
       let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
       
       let persistentURL = self.applicaitonDocumentDirectory.appendingPathComponent("\(PersistanceManager.moduleName).sqlite")
       
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentURL, options: [NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption: true])
        } catch  {
            fatalError("Coordinator store error! - \(error)")
        }
       return coordinator
    }()
    
    
    lazy var context : NSManagedObjectContext = {
        let manageObjectcontext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        manageObjectcontext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return manageObjectcontext
    }()
    
    /*  OLD METHDOS
     
    lazy var context = persistentContainer.viewContext
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData_Storage")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()*/
    
    ////  2
    
    // MARK:- FOR THE SAVE
    func save () {
        if context.hasChanges {
            do {
                try context.save()
                print("Saved successfully")
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
     ////  3
    
    // MARK:- FOR RETRIVED DATA GENERIC METHODS FOR THE FETCHING MODELS
    func fetch<T:NSManagedObject>(_ objectType: T.Type) -> [T]{
        let entityName = String(describing: objectType)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let fetchedOjects = try context.fetch(fetchRequest) as? [T]
            return fetchedOjects ?? [T]()
        }catch {
            print("Error \(error.localizedDescription)")
            return  [T]()
        }
    }
}

