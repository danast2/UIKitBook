//
//  ViewController.swift
//  NavigationApp
//
//  Created by Даниил Асташов on 25.11.2024.
//

import UIKit

class ViewController: UIViewController {
    let storyboardInstance = UIStoryboard(name: "Main", bundle: nil)
    
    // перейти к зеленой сцене
    @IBAction func toGreenScene(_ sender: UIButton) {
         // получаем ссылку на следующий контроллер
         // в данном случае следующий - это зеленый
         let nextViewController = storyboardInstance.instantiateViewController(withIdentifier: "greenController")
         // обращаемся к Navigation Controller
         // и вызываем метод перехода к новому контроллеру
         self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    // перейти к желтой сцене
    @IBAction func toYellowScene(_ sender: UIButton) {
         let nextViewController = storyboardInstance.instantiateViewController(withIdentifier: "yellowController")
         self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    // перейти к корневой сцене
    @IBAction func toRootScene(_ sender: UIButton) {
         // обращаемся к Navigation Controller
         // и вызываем метод перехода к корневому контроллеру
         self.navigationController?.popToRootViewController(animated: true)
    }
    @IBAction func toPreviousScene(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

