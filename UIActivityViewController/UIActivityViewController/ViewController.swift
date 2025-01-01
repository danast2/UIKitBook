//
//  ViewController.swift
//  UIActivityViewController
//
//  Created by Даниил Асташов on 01.01.2025.
//

import UIKit

class ViewController: UIViewController {
    var buttonShare = UIButton()
    var textField = UITextField()
    var activityViewController: UIActivityViewController? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //MARK: - Method
    func createTextField(){
        self.textField.frame = CGRect(x: 0, y: 0, width: 280, height: 30)
        self.textField.center = self.view.center
        self.textField.borderStyle = UITextField.BorderStyle.roundedRect
        self.textField.placeholder = "enter text to share"
    }

}

