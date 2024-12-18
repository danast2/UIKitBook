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
    @IBAction func saveDataWithProperty(_ sender: UIButton) {
        self.navigationController?.viewControllers.forEach { viewController in
            (viewController as? ViewController)?.updatedData = dataTextField.text ?? ""
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // определяем идентификатор segue
     switch segue.identifier {
     case "toFirstScreen":
         // обрабатываем переход
         prepareFirstScreen(segue)
     default:
         break
     }
    }
    // подготовка к переходу на первый экран
    private func prepareFirstScreen(_ segue: UIStoryboardSegue) {
     // безопасно извлекаем опциональное значение
     guard let destinationController = segue.destination as? ViewController else {
         return
     }
        destinationController.updatedData = dataTextField.text ?? ""
    }
}
