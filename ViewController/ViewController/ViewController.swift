//
//  ViewController.swift
//  ViewController
//
//  Created by Даниил Асташов on 24.12.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var hiLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func showButton(_ sender: Any) {
        self.hiLabel.text = "Hi"
        self.alert(title: "Ошибка", message: "что-то не так", style: .alert)
    }
    //2
    func alert(title: String, message: String, style: UIAlertController.Style){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "ok", style: .cancel) { (action) in
            let textAlert = alertController.textFields?.first
            self.hiLabel.text! += (", ") + (textAlert?.text!)! + ("!")
        }
        alertController.addTextField{ (textField) in
            textField.isSecureTextEntry = true
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    

}
