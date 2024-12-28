//
//  ViewController.swift
//  UIPickerView
//
//  Created by Даниил Асташов on 28.12.2024.
//

import UIKit

class ViewController: UIViewController {
    
    let picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.center = self.view.center
        //подписаться
        picker.dataSource = self
        picker.delegate = self
        
        self.view.addSubview(picker)
    }


}

extension ViewController: UIPickerViewDataSource{
    
    //сколько компонентов выводится
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    //сколько строк в компоненте
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    
    
    
}

extension ViewController: UIPickerViewDelegate{
    
}
