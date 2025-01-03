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
        
        var tabBarItem = UITabBarItem()
        tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        
        self.tabBarItem = tabBarItem
        self.view.backgroundColor = UIColor.red
        self.navigationItem.title = "first VC"
    }


}

