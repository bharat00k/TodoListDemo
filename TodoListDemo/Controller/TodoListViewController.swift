//
//  ViewController.swift
//  TodoListDemo
//
//  Created by Bharat Khatke on 06/09/19.
//  Copyright © 2019 GayaInfoTech Pvt. Ltd. All rights reserved.
//

import UIKit

let plistPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

class TodoListViewController: UITableViewController {
    
    
    var todoListArray = [ItemModel]()
    var userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let object = ItemModel()
//        object.title = "Milk"
//        self.todoListArray.append(object)
//
//        let object1 = ItemModel()
//        object1.title = "Find boom"
//        self.todoListArray.append(object1)
//
//        let object2 = ItemModel()
//        object2.title = "Drop Weapons"
//        self.todoListArray.append(object2)
        
    
        loadItems()
        
    }
    
    func loadItems()  {
        if let data = try? Data(contentsOf: plistPath!) {
            let decoder = PropertyListDecoder()
            do {
                todoListArray = try decoder.decode([ItemModel].self, from: data)
            }catch {
                print("Error decoding item array, \(error)")
            }
        }
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
        saveTodoList()
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
                self.todoListArray.append(object)
                self.saveTodoList()
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func saveTodoList()  {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(self.todoListArray)
            try data.write(to: plistPath!)
        }catch {
            print("Error Occured: \(error)")
        }
        
        self.tableView.reloadData()
    }
    
}

