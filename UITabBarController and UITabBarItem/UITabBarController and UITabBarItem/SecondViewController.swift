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
        self.view.backgroundColor = UIColor.green
        self.navigationItem.title = "second VC"
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
    }
    
    required init?(coder: NSCoder) {
            super.init(coder: coder)
    }

}
