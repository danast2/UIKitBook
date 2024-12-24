//
//  ViewController.swift
//  ViewController
//
//  Created by Даниил Асташов on 24.12.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Error", message: "Ahtung, you have an alert", preferredStyle: .alert)
        let action = UIAlertAction(title: "ok", style: .cancel) { (action) in
            let text = alertController.textFields?.first?.text
            print(text ?? "nil text")
        }
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    

}
