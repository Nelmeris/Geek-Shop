//
//  CatalogDBService.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 18.02.2020.
//

import Foundation
import CoreData

final class CatalogDBService: BaseDBService {
    
    let entityName = "Catalog"
    
    func load() throws -> [Catalog] {
        let request: NSFetchRequest<Catalog> = NSFetchRequest(entityName: entityName)
        request.sortDescriptors = [ NSSortDescriptor(key: "id", ascending: true) ]
        return try BaseDBService.context.fetch(request)
    }
    
    func load(id: String) throws -> Catalog? {
        let request: NSFetchRequest<Catalog> = NSFetchRequest(entityName: entityName)
        request.predicate = NSPredicate(format: "id == %@", id)
        return try BaseDBService.context.fetch(request).first
    }
    
}
