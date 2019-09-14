//
//  ViewController.swift
//  TodoListDemo
//
//  Created by Bharat Khatke on 06/09/19.
//  Copyright © 2019 GayaInfoTech Pvt. Ltd. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var todoListArray = ["Study Hard", "Job Change", "Moving to Pune"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoListArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoListCell", for: indexPath)
        
        cell.textLabel?.text = todoListArray[indexPath.row]
       // cell.accessoryType = .checkmark
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    @IBAction func addNewTodoListPressed(_ sender: UIBarButtonItem) {
    }
    
}

