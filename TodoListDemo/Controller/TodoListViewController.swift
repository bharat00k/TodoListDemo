//
//  ViewController.swift
//  TodoListDemo
//
//  Created by Bharat Khatke on 06/09/19.
//  Copyright © 2019 GayaInfoTech Pvt. Ltd. All rights reserved.
//

import UIKit
import CoreData

let plistPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

class TodoListViewController: UITableViewController {
    
    
    var todoListArray = [Item]()
    var userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        loadItems()
        
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

        //delete Item from list from coreData
      //  mainContext.delete(todoListArray[indexPath.row])
        
        todoListArray[indexPath.row].done = !todoListArray[indexPath.row].done
        saveTodoList()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    @IBAction func addNewTodoListPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if textField.text != "" {
                
                let newobject = Item(context: mainContext)
                newobject.title = textField.text!
                newobject.done  = false
                self.todoListArray.append(newobject)
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
    
    //MARK:- Module manupulation Methods
    func saveTodoList()  {
        
        do {
           try mainContext.save()
        }catch {
            print("Error saving context :- \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems()  {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
      //  let fetchRequest = NSFetchRequest<Item>(entityName: "Item")
        do  {
            self.todoListArray = try mainContext.fetch(fetchRequest)
        }
        catch {
            print("Error while fetching data: \(error)")
        }
        
        self.tableView.reloadData()
    }
    
}

