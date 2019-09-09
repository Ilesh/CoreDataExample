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
