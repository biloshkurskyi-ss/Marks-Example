//
//  StorageService.swift
//  Marks-Example
//
//  Created by Sergey Biloshkurskyi on 11/3/17.
//  Copyright © 2017 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation
import RealmSwift

class StorageService: StorageServiceType {
    
    // MARK: -
    static var maxUserId: Int {
        let realm = try! Realm()
        return realm.objects(User.self).max(ofProperty: "id") as Int? ?? 0
    }
    
    // MARK: - Instance Methods
    func add(new users: [User]) {
        let realm = try! Realm()
        try! realm.write {
            for user in users {
                realm.add(user)
            }
        }
    }
    
    func users() -> Results<User> {
        let realm = try! Realm()
        return realm.objects(User.self).sorted(byKeyPath: "id")
    }
    
    func update(_ user: User, score: Int) {
        let realm = try! Realm()
        try! realm.write {
            user.score = score
        }
    }
    
    func remove(_ user: User) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(user)
        }
    }
}
