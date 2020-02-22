//
//  CoreDataStack.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 22.02.2020.
//

import Foundation
import CoreData

final class CoreDataStack {
    
    private let modelName: String
    private let storeIsReady = DispatchGroup()
    
    // MARK: - Init
    
    init(modelName: String = "DataModel") {
        self.modelName = modelName
        registerStore()
    }
    
    // MARK: - Public
    
    lazy var mainContext: NSManagedObjectContext = {
        storeIsReady.wait()
            
        let context = self.persistentContainer.viewContext
        context.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        
        return context
    }()
    
    func makePrivateContext() -> NSManagedObjectContext {
        storeIsReady.wait()

        let context = self.persistentContainer.newBackgroundContext()
        context.parent = mainContext
        
        return context
    }
    
    func saveToStore() {
        storeIsReady.wait()
        
        guard mainContext.hasChanges else {
            debugPrint("Data has not changes")
            return
        }
        do {
            try mainContext.save()
            mainContext.reset()
            debugPrint("Data succesfully saved to store")
        } catch {
            debugPrint("Data not saved to store with error \(error)")
        }
    }
    
    // MARK: - Private
    
    private lazy var persistentContainer: NSPersistentContainer = {
        return NSPersistentContainer(name: self.modelName)
    }()
    
    private func registerStore() {
        storeIsReady.enter()
        
        DispatchQueue.global(qos: .background).async {
            self.persistentContainer.loadPersistentStores { (storeDescription, error) in
                if let url = storeDescription.url {
                    debugPrint("Persistent store created: \(url.absoluteString)")
                }
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
                self.storeIsReady.leave()
            }
        }
    }
    
}
