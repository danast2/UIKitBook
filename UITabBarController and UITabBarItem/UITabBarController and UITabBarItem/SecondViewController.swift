//
//  SecondViewController.swift
//  UITabBarController and UITabBarItem
//
//  Created by Даниил Асташов on 03.01.2025.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var tabBarItem = UITabBarItem()
        tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        self.tabBarItem = tabBarItem
        
        self.navigationItem.title = "second VC"
        self.view.backgroundColor = UIColor.green
    }
    

}
