//
//  StorageServiceType.swift
//  Marks-Example
//
//  Created by Sergey Biloshkurskyi on 11/3/17.
//  Copyright © 2017 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation
import RealmSwift

protocol StorageServiceType {
    static var maxUserId: Int { get }
    
    func add(new users: [User])
    func users() -> Results<User>
    func update(_ user: User, score: Int)
    func remove(_ user: User)
}
