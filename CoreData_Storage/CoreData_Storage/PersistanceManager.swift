//
//  PersistanceManager.swift
//  CoreDataDemo
//
//  Created by Ilesh's 2018 on 06/09/19.
//  Copyright © 2019 Ilesh's. All rights reserved.
//

import UIKit
import CoreData

final class PersistanceManager {
    static let shared = PersistanceManager()
    private init(){
        
    }
    
    lazy var context = persistentContainer.viewContext
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData_Storage")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
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

