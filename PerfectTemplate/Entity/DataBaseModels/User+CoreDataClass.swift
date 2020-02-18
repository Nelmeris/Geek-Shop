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
    
}
