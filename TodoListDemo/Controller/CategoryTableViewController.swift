//
//  CategoryTableViewController.swift
//  TodoListDemo
//
//  Created by Bharat Khatke on 16/09/19.
//  Copyright © 2019 GayaInfoTech Pvt. Ltd. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    var categoryList: Results<Category>?
    
    var realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()

    }
    
    

    
    @IBAction func addNewTodoListPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            if textField.text != "" {
                
                let newobject = Category()
                newobject.name = textField.text!
                self.save(category: newobject)
            }
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add new Category"
            textField = alertTextField
            
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK:- TableView DataSource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)

        cell.textLabel?.text = categoryList?[indexPath.row].name ?? ""
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toItemList", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    //MARK:- Module manupulation Methods
    func save(category: Category)  {
        do {
            try realm.write {
                realm.add(category)
            }
        }catch {
            print("Error saving realm Data :- \(error)")
        }
        
        self.tableView.reloadData()
    }
    

    func loadCategory()  {
        self.categoryList = realm.objects(Category.self)

        
        self.tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toItemList" {
            let destinationVC = segue.destination as! TodoListViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCatory = categoryList?[indexPath.row]
            }
        }
    }

}
