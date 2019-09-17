//
//  Category.swift
//  TodoListDemo
//
//  Created by Bharat Khatke on 17/09/19.
//  Copyright © 2019 GayaInfoTech Pvt. Ltd. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name: String = ""
    let items = List<Item>()// Forword Relationship- one-Many
}
