//
//  SecondViewController.swift
//  UINavigationViewController
//
//  Created by Даниил Асташов on 02.01.2025.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "secondVC"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.perform(#selector(goBack), with: nil, afterDelay: 3.0)
    }
    
    @objc
    func goBack(){
        //self.navigationController?.popViewController(animated: true)
        //получаем текущий массив контроллера
        var currentControllerArray = self.navigationController?.viewControllers
    }
    
}
