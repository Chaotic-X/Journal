//
//  EntryController.swift
//  Journal
//
//  Created by Caleb Hicks on 10/1/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation

class EntryController {
    
    static let shared = EntryController()
    private init() {}
    
    func addEntryWith(title: String, text: String) {
        Entry(titleParameter: title, textParameter: text)
        saveToPersistentStorage()
    }
    
    func remove(entry: Entry) {
        //This way makes sure you reference the right MOC
        entry.managedObjectContext?.delete(entry)
        saveToPersistentStorage()
    }
    
    func update(entry: Entry, with title: String, text: String) {
        entry.title = title
        entry.text = text
        saveToPersistentStorage()
    }
	
	// MARK: - Persistence

//    private func loadFromPersistentStorage() {
//
//    }
    
    private func saveToPersistentStorage() {
        try! CoreDataStack.context.save()
    }

//Don't need our Source of Truth... because we are getting that from CoreData... Persistent Store
//    // MARK: Properties
//
//    private(set) var entries = [Entry]()
//
}
