//
//  ItemModel.swift
//  TodoListDemo
//
//  Created by Bharat Khatke on 15/09/19.
//  Copyright © 2019 GayaInfoTech Pvt. Ltd. All rights reserved.
//

import UIKit

class ItemModel: Encodable, Decodable {
    var title: String = ""
    var done: Bool    = false

}
