//
//  UserDBService.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 14.02.2020.
//

import Foundation
import CoreData

final class UserDBService: BaseDBService {
    
    let entityName = "User"
    
    func load() throws -> [User] {
        let request: NSFetchRequest<User> = NSFetchRequest(entityName: entityName)
        request.sortDescriptors = [ NSSortDescriptor(key: "id", ascending: true) ]
        return try context.fetch(request)
    }
    
    func load(id: String) throws -> User? {
        let request: NSFetchRequest<User> = NSFetchRequest(entityName: entityName)
        request.predicate = NSPredicate(format: "id == %@", id)
        return try context.fetch(request).first
    }
    
    func load(username: String) throws -> User? {
        let request: NSFetchRequest<User> = NSFetchRequest(entityName: entityName)
        request.predicate = NSPredicate(format: "username CONTAINS[cd] %@", username)
        return try context.fetch(request).first
    }
    
    func save(with data: UserData) throws -> User {
        var user: User!
        if let loadedUser = try load(username: data.username) {
            user = loadedUser
        } else {
            let users = try load()
            let id = (users.last?.id ?? -1) + 1
            user = User(context: context)
            user.id = id
            user.creationDate = Date()
        }
        fillUser(user, with: data)
        try saveContext()
        return user
    }
    
    func update(_ user: User, with data: UserData) throws -> User {
        fillUser(user, with: data)
        try saveContext()
        return user
    }
    
    private func fillUser(_ user: User, with data: UserData) {
        user.username = data.username
        user.name = data.name
        user.surname = data.surname
        user.password = data.password
        user.email = data.email
        user.gender = data.gender
        user.creditCard = data.creditCard
        user.bio = data.bio
    }
    
}
