//
//  UserTableViewCell.swift
//  Marks-Example
//
//  Created by Sergey Biloshkurskyi on 11/3/17.
//  Copyright © 2017 Sergey Biloshkurskyi. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    static let identifier = "userCellIdentifier"
    
    // MARK: - Cell Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.textLabel?.text = nil
        self.detailTextLabel?.text = nil
    }
    
    // MARK: - Instance Methods
    func configure(with user: User) {
        self.textLabel?.text = user.name
        self.detailTextLabel?.text = "Score: \(user.score)"
    }
}
