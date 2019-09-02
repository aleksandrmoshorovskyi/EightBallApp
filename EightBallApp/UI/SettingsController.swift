//
//  SettingsController.swift
//  EightBallApp
//
//  Created by Aleksandr Moroshovskyi on 9/2/19.
//  Copyright © 2019 Aleksandr Moroshovskyi. All rights reserved.
//

import UIKit

class SettingsController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    @IBOutlet weak var tableView: UITableView!
    var dataSource = [Magic]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "The Answers List"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellID")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let data = DataManager.fetchData(type: Magic.self)
        if let array = data.array {
            dataSource = array
        } else if let error = data.error {
            print("No data\(error)", error.userInfo)
        }
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "New answer", message: "Enter your answer", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            let textField = alert.textFields?.first
            let result = DataManager.saveData(type: Magic.self, forKey: "answer", value: textField?.text ?? "")
            if let obj = result.entity {
                self.dataSource.append(obj)
                self.tableView.reloadData()
            } else if let error = result.error {
                print("Could not save \(error)", error.userInfo)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CellID")
        let obj = dataSource[indexPath.row]
        cell?.textLabel?.text = obj.answer ?? ""
        
        return cell!
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            DataManager.deleteData(object: dataSource[indexPath.row])
            
            let data = DataManager.fetchData(type: Magic.self)
            if let array = data.array {
                dataSource = array
            } else if let error = data.error {
                print("Could not save \(error)", error.userInfo)
            }
        }
        
        tableView.reloadData()
    }
}
