//
//  AppDelegate.swift
//  CoreData_Storage
//
//  Created by Ilesh's 2018 on 09/09/19.
//  Copyright © 2019 Ilesh's. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Add_Data()
        fetchrecords()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        PersistanceManager.shared.save()
    }

    // THIS IS THE SIMPLE FUNCTION FOR THE SAVING RECORDS
    func Add_Data(){
        guard let entity = NSEntityDescription.entity(forEntityName: "User", in: PersistanceManager.shared.context) else {
            fatalError("entify not found")
            return
        }
        let user = NSManagedObject.init(entity: entity, insertInto: PersistanceManager.shared.context)
        user.setValue("Ilesh", forKey: "name")
        user.setValue(25, forKey: "age")
        user.setValue("secret@test.com", forKey: "email")
        
        do {
            try PersistanceManager.shared.context.save()
            print("Record saved successfully")
        }catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    // FOR FETCH RECORDS
    func fetchrecords() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"User")
        do {
            if let result = try PersistanceManager.shared.context.fetch(fetchRequest) as? [NSManagedObject] {
                for element in result {
                    print("Name: \(element.value(forKey: "name") as? String ?? "No Keyfound")")
                    print("Email: \(element.value(forKey: "email") as? String ?? "No Keyfound")")
                    print("Age: \(element.value(forKey: "age") as? Int ?? -1 )")
                }
            }
        } catch  {
            print("Error: \(error.localizedDescription)")
        }
    }
}

