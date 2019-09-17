//
//  Item.swift
//  TodoListDemo
//
//  Created by Bharat Khatke on 17/09/19.
//  Copyright © 2019 GayaInfoTech Pvt. Ltd. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var done: Bool = false
    @objc dynamic var title: String = ""
    var parentCatrgory = LinkingObjects(fromType: Category.self, property: "items") // Inverse relationship
}
