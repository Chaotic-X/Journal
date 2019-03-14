//
//  CoreDataStack.swift
//  Journal
//
//  Created by Alex Lundquist on 3/14/19.
//  Copyright © 2019 DevMountain. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    //NSPersistentContainer
    static let container: NSPersistentContainer = {
        let containner = NSPersistentContainer(name: "Journal") // <-- The string here has "HAS TO BE" the same as your APP Name... Or it will crash burn and blow up the universe - 1) APP NAME 2) .xcdatamodeld file 3) and the Above NSPersistentContainer
        containner.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                fatalError("DIE DIE DIE - Failed to load Persistent Stores")
            }
        })
        return containner
    }() //
    
    static var context: NSManagedObjectContext {
        return container.viewContext
    }
}
