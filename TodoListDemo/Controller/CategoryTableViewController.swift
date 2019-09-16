//
//  CategoryTableViewController.swift
//  TodoListDemo
//
//  Created by Bharat Khatke on 16/09/19.
//  Copyright © 2019 GayaInfoTech Pvt. Ltd. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    var categoryList = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategory()

    }
    
    

    
    @IBAction func addNewTodoListPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            if textField.text != "" {
                
                let newobject = Category(context: mainContext)
                newobject.name = textField.text!
                self.categoryList.append(newobject)
                self.saveTodoList()
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
        return categoryList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        
        let dataObject = categoryList[indexPath.row]
        cell.textLabel?.text = dataObject.name
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toItemList", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
    

    func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest())  {

        do  {
            self.categoryList = try mainContext.fetch(request)
        }
        catch {
            print("Error while fetching data: \(error)")
        }
        
        self.tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toItemList" {
            let destinationVC = segue.destination as! TodoListViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCatory = categoryList[indexPath.row]
            }
        }
    }

}
