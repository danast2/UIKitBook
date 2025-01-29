//
//  MyTableViewController.swift
//  UITableViewController,MVC,UserDefaults
//
//  Created by Даниил Асташов on 29.01.2025.
//

import UIKit

class MyTableViewController: UITableViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var polSegment: UISegmentedControl!
    @IBOutlet weak var isPushedOn: UISwitch!
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load
        if let name = userDefaults.object(forKey: "name"){
            nameTextField.text = name as? String
        }
        
        if let last = userDefaults.object(forKey: "lastName"){
            lastNameTextField.text = last as? String
        }
        
        if let isSwitch = userDefaults.object(forKey: "switch"){
            isPushedOn.isOn = isSwitch as! Bool
        }
        
        if let pol = userDefaults.object(forKey: "segment"){
            polSegment.selectedSegmentIndex = pol as! Int
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        userDefaults.setValue(nameTextField.text, forKey: "name")
        userDefaults.setValue(lastNameTextField.text, forKey: "lastName")
        userDefaults.set(isPushedOn.isOn, forKey: "switch")
        userDefaults.set(polSegment.selectedSegmentIndex, forKey: "segment")
        print("save")
        lastNameTextField.resignFirstResponder()
    }
}
