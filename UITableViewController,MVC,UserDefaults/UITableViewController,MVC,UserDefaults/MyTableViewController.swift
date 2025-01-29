//
//  MyTableViewController.swift
//  UITableViewController,MVC,UserDefaults
//
//  Created by Даниил Асташов on 29.01.2025.
//

import UIKit

class MyTableViewController: UITableViewController {
    
    var itemArray = [Model]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item = Model(name: "Даниил Дементьев", prof: "прогер")
        itemArray.append(item)
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MyTableViewCell{
            
            let item = itemArray[indexPath.row]
            
            cell.refresh(item)
            
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
