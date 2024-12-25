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
        self.alert(title: "Ошибка", message: "что-то не так", style: .alert)
    }
    //2
    func alert(title: String, message: String, style: UIAlertController.Style){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "ok", style: .cancel) { (action) in
            
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    

}
