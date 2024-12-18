//
//  ViewController.swift
//  TransferApp
//
//  Created by Даниил Асташов on 02.12.2024.
//

import UIKit

class ViewController: UIViewController, DataUpdateProtocol {
    @IBOutlet var dataLabel: UILabel!
    var updatedData: String = "Test data"
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func editDataWithProperty(_ sender: UIButton) {
        // получаем вью контроллер, в который происходит переход
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController

        // передаем данные
        editScreen.updatingData = dataLabel.text ?? ""

        // переходим к следующему экрану
        self.navigationController?.pushViewController(editScreen, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLabel(withText: updatedData)
    }
    // Обновляем данные в текстовой метке
    private func updateLabel(withText text: String) {
        dataLabel.text = updatedData
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // определяем идентификатор segue
         switch segue.identifier {
         case "toEditScreen":
             // обрабатываем переход
             prepareEditScreen(segue)
         default:
             break
         }
    }
    // подготовка к переходу на экран редактирования
    private func prepareEditScreen(_ segue: UIStoryboardSegue) {
     // безопасно извлекаем опциональное значение
     guard let destinationController = segue.destination as? SecondViewController else {
         return
     }
     destinationController.updatingData = dataLabel.text ?? ""
    }
    @IBAction func unwindToFirstScreen(_ segue: UIStoryboardSegue) {}
    func onDataUpdate(data: String) {
         updatedData = data
         updateLabel(withText: data)
    }
    // переход от А к Б
    // передача данных с помощью свойства и установка делегата
    @IBAction func editDataWithDelegate(_ sender: UIButton) {
        // получаем вью контроллер
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        // передаем данные
        editScreen.updatingData = dataLabel.text ?? ""

        // устанавливаем текущий класс в качестве делегата
        editScreen.handleUpdatedDataDelegate = self
        // открываем следующий экран
        self.navigationController?.pushViewController(editScreen, animated: true)
    }
    // переход от А к Б
    // передача данных с помощью свойства и инициализация замыкания
    @IBAction func editDataWithСlosure(_ sender: UIButton) {
         // получаем вью контроллер
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let editScreen = storyboard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
         // передаем данные
         editScreen.updatingData = dataLabel.text ?? ""

         // передаем необходимое замыкание
         editScreen.completionHandler = { [unowned self] updatedValue in
             updatedData = updatedValue
             updateLabel(withText: updatedValue)
         }
         // открываем следующий экран
         self.navigationController?.pushViewController(editScreen, animated: true)
    }
}

