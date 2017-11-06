//
//  UIView+Ext.swift
//  Marks-Example
//
//  Created by Sergey Biloshkurskyi on 11/3/17.
//  Copyright © 2017 Sergey Biloshkurskyi. All rights reserved.
//

import UIKit

extension UIView {
    func customize() {
        self.layer.cornerRadius = 5.0
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.black.cgColor
    }
}
