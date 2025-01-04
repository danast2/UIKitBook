//
//  ViewController.swift
//  UILabel
//
//  Created by Даниил Асташов on 04.01.2025.
//

import UIKit

class ViewController: UIViewController {
    
    let myLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labelFrame = CGRect(x: 0, y: 0, width: 100, height: 50)
        
        self.myLabel.frame = labelFrame
        self.myLabel.numberOfLines = 0
        self.myLabel.lineBreakMode = .byWordWrapping
        self.myLabel.text = "ios что-то там"
        self.myLabel.adjustsFontSizeToFitWidth = true
        self.myLabel.shadowOffset = CGSize(width: 2, height: 2)
        self.myLabel.sizeToFit()
        self.myLabel.shadowColor = UIColor.lightGray
        
        self.myLabel.font = UIFont.boldSystemFont(ofSize: 24)
        self.myLabel.center = self.view.center
        self.view.addSubview(myLabel)
    }


}

