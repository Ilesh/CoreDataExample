# CoreDataExample

This is the simple core data example for the beginner. It will help to understand persistent storage in iOS and mac OSX.
This sample project and fuction will help you to develope large scale application.

##### Please note, I am assumes you are comfortable with the basics of storyboards, view controllers and basic knowledge of the iOS programing.


## Getting Started
Open Xcode and create a new iOS project based on the **Single View** App template. Name the app HitList and 
make sure Use **Core Data** is checked.

![Create Project](https://i.imgflip.com/3a2isx.jpg)

**Use Core Data** box will cause Xcode to generate boilerplate code for what is known as an` NSPersistentContainer` in `AppDelegate.swift` file.

The` NSPersistentContainer` consists of a set of objects that provides **saving** and **retrieving** information from `Core Data`. 
Inside this container is an object to manage the Core Data state as a whole, an object representing the `Data Model`, and so on.

Here we make a Singleton class for manage `NSPersistentContainer` code and make clean `AppDelegate.swift` file. 
I really love `Singleton` because it is very simple, common and easy to use in your project, For example `UserDefaults.standard` , `FileManager.default`.

###  PersistanceManager
```
final class PersistanceManager {

     ////  1
    
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
```
Now we only focus `/// 1` part of the method which created a `shared`, `context` and `persistentContainer` veriable others part will explain later. 

Now focus on `Create`a new `Entity` and its `Attributes`. In the project you will find the `yourprojectname.xcdatamodeld` that contains the entities, attributes and relationsheep. 

An **entity** is a class definition in Core Data. In a relational database, an entity corresponds to a table.

An **attribute** is a piece of information attached to a particular entity. In a database, an attribute corresponds to a particular field in a table.

A **relationship** is a link between multiple entities. In Core Data, relationships between two entities are called `to-one` relationships, while those between one and many entities are called `to-many` relationships.

![Core data .xcdatamodeld file](https://i.imgflip.com/3a2kr5.jpg)

Let's lookup the part of the **SAVE** and **FETCH** methods. 

```
func addNewRecord(){
        guard let entity = NSEntityDescription.entity(forEntityName: "User", in: PersistanceManager.shared.context) else {
            fatalError("entify not found")
        }
        let user = NSManagedObject.init(entity: entity, insertInto: PersistanceManager.shared.context)
        user.setValue("Ilesh", forKey: "name")  // STRING VALUE TYPE
        user.setValue(22, forKey: "age")        // INT VALUE TYPE
        user.setValue("secret@test.com", forKey: "email") // STRING VALUE TYPE        
        do {
            try PersistanceManager.shared.context.save()
            print("Record saved successfully")
        }catch {
            print("Error: \(error.localizedDescription)")
        }
    }
```
```
func fetchRecords() {
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
```
If all your setup is fine then you will get following 
OUTPUT

```
 Name: Ilesh
 Email: secret@test.com
 Age: 22
```
I hope you enjoy, and stay tuned for more updates! Thanks:)
