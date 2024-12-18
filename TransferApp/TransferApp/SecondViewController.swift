//
//  SecondViewController.swift
//  TransferApp
//
//  Created by Даниил Асташов on 18.12.2024.
//

import Foundation

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet var dataTextField: UITextField!
    var updatingData: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTectFieldData(withText: updatingData)
    }
    private func updateTectFieldData(withText text: String){
        dataTextField.text = text
    }

}
