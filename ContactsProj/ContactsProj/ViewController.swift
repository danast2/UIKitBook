//
//  ViewController.swift
//  ContactsProj
//
//  Created by Даниил Асташов on 23.11.2024.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    var storage: ContactStorageProtocol!
    @IBAction func showNewContactAlert(){
        //создание alert controller
        let alertController = UIAlertController(title: "Создайте новый контакт", message: "Введите имя и телефон", preferredStyle: .alert)
        alertController.addTextField{ textField in
            textField.placeholder = "Имя"
        }
        // добавляем второе текстовое поле в Alert Controller
         alertController.addTextField { textField in
             textField.placeholder = "Номер телефона"
         }
        //создаем кнопки
        //кнопки контакта
        let createButton = UIAlertAction(title: "Создать", style: .default) { _ in
            guard let contactName = alertController.textFields?[0].text, let contactPhone = alertController.textFields?[1].text else {
                return
            }
            // создаем новый контакт
             let contact = Contact(title: contactName, phone: contactPhone)
             self.contacts.append(contact)
             self.tableView.reloadData()
        }
        // кнопка отмены
        let cancelButton = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        // добавляем кнопки в Alert Controller
         alertController.addAction(cancelButton)
         alertController.addAction(createButton)
        // отображаем Alert Controller
         self.present(alertController, animated: true, completion: nil)
    }
    private var contacts:[ContactProtocol] = [] {
        didSet{
            contacts.sort(by: {$0.title < $1.title })
            storage.save(contacts: contacts)
        }
    }
    private func loadContacts() {
//     contacts.append(Contact(title: "Саня Техосмотр", phone: "+799912312323"))
//     contacts.append(Contact(title: "Владимир Анатольевич", phone: "+781213342321"))
//     contacts.append(Contact(title: "Сильвестр", phone: "+7000911112"))
        contacts = storage.load()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        storage = ContactStorage()
        loadContacts()
        // Do any additional setup after loading the view.
    }
    private func configure(cell: inout UITableViewCell, for indexPath:
    IndexPath) {
         var configuration = cell.defaultContentConfiguration()
         // имя контакта
         configuration.text = contacts[indexPath.row].title
         // номер телефона контакта
         configuration.secondaryText = contacts[indexPath.row].phone
         cell.contentConfiguration = configuration
    }

}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
        return contacts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
         if let reuseCell = tableView.dequeueReusableCell(withIdentifier:"MyCell") {
             print("Используем старую ячейку для строки с индексом \(indexPath.row)")
             cell = reuseCell
         } else {
             print("Создаем новую ячейку для строки с индексом \(indexPath.row)")
             cell = UITableViewCell(style: .default, reuseIdentifier: "MyCell")
         }
         configure(cell: &cell, for: indexPath)
         return cell
    }
}
     

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
         // действие удаления
         let actionDelete = UIContextualAction(style: .destructive, title: "Удалить") { _,_,_ in
         // удаляем контакт
         self.contacts.remove(at: indexPath.row)
         // заново формируем табличное представление
         tableView.reloadData()
     }
     // формируем экземпляр, описывающий доступные действия
     let actions = UISwipeActionsConfiguration(actions: [actionDelete])
     return actions
    }
    
}
