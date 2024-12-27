//
//  ViewController.swift
//  Switch
//
//  Created by Даниил Асташов on 26.12.2024.
//

import UIKit

class ViewController: UIViewController {
    let mySwitch = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.mySwitch.frame = CGRect(x: 100, y: 100, width: 0, height: 0)
        self.view.addSubview(self.mySwitch)
    }
}
