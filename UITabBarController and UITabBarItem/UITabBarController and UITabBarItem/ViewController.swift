//
//  ViewController.swift
//  UITabBarController and UITabBarItem
//
//  Created by Даниил Асташов on 03.01.2025.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        self.navigationItem.title = "first VC"
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

}

