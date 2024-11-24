//
//  ViewController.swift
//  ContactsProj
//
//  Created by Даниил Асташов on 23.11.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") else {
            print("Создаем новую ячейку для строки с индексом \(indexPath.row)")
            let newCell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
            var configuration = newCell.defaultContentConfiguration()
            configuration.text = "Строка \(indexPath.row)"
            newCell.contentConfiguration = configuration
            return newCell
         }
         print("Используем старую ячейку для строки с индексом \(indexPath.row)")
         return cell
    }
}
     

