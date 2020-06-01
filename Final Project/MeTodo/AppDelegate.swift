//
//  AppDelegate.swift
//  MeTodo
//
//  Created by Hien Ho Developer on 4/11/20.
//  Copyright © 2020 Hien Ho Developer. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    private let USER_HAS_BEEN_ONBOARDED = "USER_HAS_BEEN_ONBOARDED"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseManager.shared.setup()
        // FirestoreManager.shared.setup()
        
        UIApplication.shared.statusBarStyle = .lightContent

               let realm = try! Realm()
               let defaults = UserDefaults.standard
               
               // If the user has never been onboarded and they don't have any lists, create the onboarding list
               if (!defaults.bool(forKey: USER_HAS_BEEN_ONBOARDED) &&
                   realm.objects(TaskList.self).count == 0) {
                   buildOnboardingList()
               }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "MeTodo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private func buildOnboardingList() {
        let realm = try! Realm()
        try! realm.write {
            let defaultList = TaskList()
            defaultList.title = "Swipe Up"
            defaultList.imageNameId = 1
            defaultList.colorSchemeId = 0
            realm.add(defaultList)
            
            let task0 = Task()
            task0.text = "Tap a task for detail"
            task0.note = "Tapping a task will bring up its detail page. You can edit the title and the note of a task. This is also where you can delete a task by clicking the trash in the upper right hadn corner."
            
            let task1 = Task()
            task1.text = "Adding a task"
            task1.note = "Click the plus button in the list page (the screen you were just on) to add a task."
            
            let task2 = Task()
            task2.text = "Creating a new list"
            task2.note = "On the Home page, swipe right to get to the outline of a list. Click inside the outline and you can create a new list. You can create as many as you'd like!"
            
            let task3 = Task()
            task3.text = "Edit a list"
            task3.note = "On the home page, click the three vertical dots on the right hand corner of a list to begin editing. You can change the icon, color, and the name of a list. You can also delete a list from the edit screen."
            
            let task4 = Task()
            task4.text = "Reorder list"
            task4.note = "You can reorder lists by clicking the image of an up and down arrow in the top right corner of the list page."
            
            defaultList.activeTasks.append(objectsIn: [task0, task1, task2, task3, task4])
            UserDefaults.standard.set(true, forKey: USER_HAS_BEEN_ONBOARDED)
        }
    }

}

