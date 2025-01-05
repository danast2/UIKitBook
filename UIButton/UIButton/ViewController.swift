//
//  ViewController.swift
//  UIButton
//
//  Created by Даниил Асташов on 05.01.2025.
//

import UIKit

class ViewController: UIViewController {
    var myButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        myButton = UIButton(type: .roundedRect)
        myButton.frame = CGRect(x: 100, y: 100, width: 150, height: 20)
        myButton.setTitle("press me", for: .normal)
        myButton.setTitle("im pressed", for: .highlighted)
        myButton.addTarget(self, action: #selector(buttonIsPressed), for: .touchDown)
        myButton.addTarget(self, action: #selector(buttonIsTaped), for: .touchUpInside)
        self.view.addSubview(myButton)
    }
    
    @objc func buttonIsPressed(){
        print("buttonPressed")
    }
    
    @objc func buttonIsTaped(){
        print("buttonIsTaped")
    }

}

