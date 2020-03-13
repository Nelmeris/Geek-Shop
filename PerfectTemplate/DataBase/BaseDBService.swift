//
//  CoreDataService.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 14.02.2020.
//

import Foundation
import CoreData

class BaseDBService {
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    let context = BaseDBService.persistentContainer.viewContext
    
    func saveContext() throws {
        try context.save()
    }
    
}
