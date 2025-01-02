//
//  ViewController.swift
//  UINavigationViewController
//
//  Created by Даниил Асташов on 02.01.2025.
//

import UIKit

class ViewController: UIViewController {
    
    var displaySecondButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "first vc"
        self.displaySecondButton = UIButton(type: .system)
        self.displaySecondButton.setTitle("Second vc", for: .normal)
        self.displaySecondButton.sizeToFit()
        self.displaySecondButton.center = self.view.center
        self.displaySecondButton.addTarget(self, action: #selector(performDisplaySecondVC(parametrSender:)), for: .touchUpInside)
        self.view.addSubview(displaySecondButton)
    }
    @objc
    func performDisplaySecondVC(parametrSender: Any) {
        let secondVC = SecondViewController()
        self.navigationController?.pushViewController(secondVC, animated: true)
    }


}

