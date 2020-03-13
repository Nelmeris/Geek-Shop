//
//  User+CoreDataClass.swift
//  PerfectTemplate
//
//  Created by Artem Kufaev on 18.02.2020.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject, Encodable {
    
    enum CodingKeys: String, CodingKey {
        case id, username, name, surname, password, email, gender, bio, creditCard, creationDate
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(username, forKey: .username)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(surname, forKey: .surname)
        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(gender, forKey: .gender)
        try container.encodeIfPresent(bio, forKey: .bio)
        try container.encodeIfPresent(creditCard, forKey: .creditCard)
        try container.encodeIfPresent(creationDate, forKey: .creationDate)
    }
    
    static func fetchAll(in context: NSManagedObjectContext) -> [User] {
        let request = NSFetchRequest<User>(entityName: "User")
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        do {
            return try context.fetch(request)
        } catch {
            debugPrint("Can't fetch users")
            debugPrint((error as NSError).userInfo)
            return []
        }
    }
    
    static func fetchById(_ id: Int, in context: NSManagedObjectContext) -> User? {
        let request = NSFetchRequest<User>(entityName: "User")
        request.predicate = NSPredicate(format: "id == %d", id)
        do {
            return try context.fetch(request).first
        } catch {
            debugPrint("Can't fetch user with id \(id)")
            debugPrint((error as NSError).userInfo)
            return nil
        }
    }
    
    static func fetchByUsername(_ username: String, in context: NSManagedObjectContext) -> User? {
        let request = NSFetchRequest<User>(entityName: "User")
        request.predicate = NSPredicate(format: "username LIKE[cd] %@", username)
        do {
            let users = try context.fetch(request)
            return users.first
        } catch {
            debugPrint("Can't fetch user with username \(username)")
            debugPrint((error as NSError).userInfo)
            return nil
        }
    }
    
    enum MakeError: Error {
        case userByIdNotFound
        case usernameIsAlreadyTaken
    }
    
    static func update(for id: Int, from data: UserData, in context: NSManagedObjectContext) throws -> User {
        guard let userById = User.fetchById(id, in: context) else {
            throw MakeError.userByIdNotFound
        }
        if let userByUsername = User.fetchByUsername(data.username, in: context) {
            if userByUsername != userById {
                throw MakeError.usernameIsAlreadyTaken
            } else {
                userByUsername.update(from: data)
                return userByUsername
            }
        } else {
            userById.update(from: data)
            return userById
        }
    }
    
    static func make(from data: UserData, in context: NSManagedObjectContext) throws -> User {
        guard User.fetchByUsername(data.username, in: context) == nil else {
            throw MakeError.usernameIsAlreadyTaken
        }
        let users = fetchAll(in: context)
        let user = User(context: context)
        user.basket = Basket(context: context)
        if let id = users.last?.id {
            user.id = id + 1
        }
        user.update(from: data)
        user.creationDate = Date()
        return user
    }
    
    func update(from data: UserData) {
        self.username = data.username
        self.name = data.name
        self.surname = data.surname
        self.password = data.password
        self.email = data.email
        self.gender = data.gender
        self.creditCard = data.creditCard
        self.bio = data.bio
    }
    
}
