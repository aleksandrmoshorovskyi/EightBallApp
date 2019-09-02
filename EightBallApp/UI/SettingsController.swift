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
    var dataSource = ["111", "222", "333"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "The Answers List"
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellID")
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {

    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CellID")
        let obj = dataSource[indexPath.row]
        cell?.textLabel?.text = obj
        
        return cell!
    }
    
    //MARK: - UITableViewDelegate
}
