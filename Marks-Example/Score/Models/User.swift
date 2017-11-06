//
//  User.swift
//  Marks-Example
//
//  Created by Sergey Biloshkurskyi on 11/3/17.
//  Copyright © 2017 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    
    // MARK: - Init
    convenience init(score: Int, id: Int) {
        self.init()
        self.score = score
        self.id = id
    }
    
    // MARK: - Persisted Properties
    @objc dynamic var score = 0
    @objc dynamic var id = 0
    
    // MARK: - Dynamic properties
    var name: String {
        return "User #\(id)"
    }
    
    // MARK: - Meta
    override static func primaryKey() -> String? {
        return "id"
    }
}

extension User {
    // MARK: - Class Constructors
    static func newUser() -> User {
        return User(score: Int(arc4random_uniform(100)), id: StorageService.maxUserId + 1 )
    }
    
    static func dozenUser() -> [User] {
        var users = [User]()
        let maxId = StorageService.maxUserId
        for i in 0..<10 {
            users.append(User(score: Int(arc4random_uniform(100)), id: maxId + i + 1 ))
        }
        return users
    }
}
