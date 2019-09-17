//
//  ViewController.swift
//  TodoListDemo
//
//  Created by Bharat Khatke on 06/09/19.
//  Copyright © 2019 GayaInfoTech Pvt. Ltd. All rights reserved.
//

import UIKit
import RealmSwift

let plistPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

class TodoListViewController: UITableViewController {
    
    
    var todoListArray: Results<Item>?
    
    var realm = try! Realm()
    

    var selectedCatory: Category? {
        didSet {
            loadItems()
        }
    }
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListArray?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoListCell", for: indexPath)
      
        cell.textLabel?.text = todoListArray?[indexPath.row].title ?? "No Item"
        cell.accessoryType = todoListArray?[indexPath.row].done ?? false ? .checkmark : .none
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //Update Data
        if let item = todoListArray?[indexPath.row] {
            do {
                try realm.write {
                    item.done = !item.done
                }
            }catch {
                print("Error saving realm data :- \(error)")
            }
        }
        
        //Delete Items
//        if let item = todoListArray?[indexPath.row] {
//            do {
//                try realm.write {
//                    realm.delete(item)
//                }
//            }catch {
//                print("Error saving realm data :- \(error)")
//            }
//        }
        
         self.tableView.reloadData()

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    @IBAction func addNewTodoListPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if textField.text != "" {
                
                if let currentCategory = self.selectedCatory {
                   
                    do {
                       try self.realm.write {
                            let newobject = Item()
                            newobject.title = textField.text!
                            newobject.done  = false
                            currentCategory.items.append(newobject)
                        }
                    }catch {
                        print("Error While Saving data \(error)")
                    }
                }
                    
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
    
    //MARK:- Module manupulation Methods
    func saveTodoList(item: Item)  {
        
        do {
            try realm.write {
                realm.add(item)
            }
        }catch {
            print("Error saving realm data :- \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadItems()  {
     
        todoListArray = selectedCatory?.items.sorted(byKeyPath: "title", ascending: true)
        
        self.tableView.reloadData()
    }
    
}
/*

extension TodoListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        loadItems(with: request, predicate: predicate)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
} */
