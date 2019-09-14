//
//  ViewController.swift
//  TodoListDemo
//
//  Created by Bharat Khatke on 06/09/19.
//  Copyright © 2019 GayaInfoTech Pvt. Ltd. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    
    var todoListArray = [ItemModel]()
    var userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let object = ItemModel()
        object.title = "Milk"
        self.todoListArray.append(object)
        
        let object1 = ItemModel()
        object1.title = "Find boom"
        self.todoListArray.append(object1)
        
        let object2 = ItemModel()
        object2.title = "Drop Weapons"
        self.todoListArray.append(object2)
        
        let object3 = ItemModel()
        object3.title = "Surrender your self"
        self.todoListArray.append(object3)
        
        let object4 = ItemModel()
        object4.title = "Find sugar"
        self.todoListArray.append(object4)
        
        let object5 = ItemModel()
        object5.title = "Find Money"
        self.todoListArray.append(object5)
        
        let object6 = ItemModel()
        object6.title = "Bharat"
        self.todoListArray.append(object6)
        
        let object7 = ItemModel()
        object7.title = "Sadabahar"
        self.todoListArray.append(object7)
        
        
//        if let arrayList = userDefaults.array(forKey: "arrayList") as? [ItemModel] {
//            todoListArray = arrayList
//        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoListCell", for: indexPath)
        
        let dataObject = todoListArray[indexPath.row]
        cell.textLabel?.text = dataObject.title
        cell.accessoryType = dataObject.done ? .checkmark : .none
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
        todoListArray[indexPath.row].done = !todoListArray[indexPath.row].done
        
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    @IBAction func addNewTodoListPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if textField.text != "" {
                
                let object = ItemModel()
                object.title = textField.text!
                object.done = false
                self.todoListArray.append(object)
//                self.userDefaults.set(self.todoListArray, forKey: "arrayList")
//                self.userDefaults.synchronize()
                
                self.tableView.reloadData()
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

