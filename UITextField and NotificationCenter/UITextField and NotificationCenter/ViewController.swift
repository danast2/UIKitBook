//
//  ViewController.swift
//  UITextField and NotificationCenter
//
//  Created by Даниил Асташов on 04.01.2025.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var myTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createTextField()
        myTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldTextDidChange(ncParam:)), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    //MARK: - Notification
    @objc func textFieldTextDidChange(ncParam: NSNotification){
        print("UITextFieldNotification = \(ncParam)")
    }
    
    
    
    //MARK: - createUI
    
    func createTextField() {
        // Устанавливаем рамку текстового поля
        let textFieldFrame = CGRect(x: 0, y: 0, width: 200, height: 31)
        self.myTextField = UITextField(frame: textFieldFrame)
        
        // Настраиваем текстовое поле
        self.myTextField.borderStyle = UITextField.BorderStyle.roundedRect
        self.myTextField.contentVerticalAlignment = .center
        self.myTextField.textAlignment = .center
        self.myTextField.placeholder = "Введите текст"
        self.myTextField.center = self.view.center
        
        // Устанавливаем делегата
        self.myTextField.delegate = self
        
        // Добавляем текстовое поле на экран
        view.addSubview(self.myTextField)
    }
    
    // MARK: - UITextFieldDelegate methods
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("textFieldShouldBeginEditing Текстовое поле готово к редактированию")
        return true // Возвращаем true, чтобы разрешить редактирование
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing Начато редактирование текстового поля")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print(" textFieldShouldEndEditing Редактирование текстового поля скоро завершится")
        return true // Возвращаем true, чтобы разрешить завершение редактирования
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing Редактирование текстового поля завершено")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        switch reason {
        case .committed:
            print("textFieldDidEndEditing Пользователь завершил редактирование (нажал Enter)")
        case .cancelled:
            print("textFieldDidEndEditing Редактирование было отменено")
        @unknown default:
            print("textFieldDidEndEditing Неизвестная причина завершения редактирования")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("shouldChangeCharactersIn Пользователь ввел символ: \(string)")
        return true // Возвращаем true, чтобы разрешить изменение текста
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("textFieldDidChangeSelection Изменился выбор текста")
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("textFieldShouldClear Текстовое поле будет очищено")
        return true // Возвращаем true, чтобы разрешить очистку
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn Пользователь нажал Return")
        if textField == myTextField{
            textField.resignFirstResponder() // Скрываем клавиатуру
        }
        return true
    }
    
    func textField(_ textField: UITextField, editMenuForCharactersIn range: NSRange, suggestedActions: [UIMenuElement]) -> UIMenu? {
        print("editMenuForCharactersIn Вызвано контекстное меню для выделенных символов")
        return nil // Возвращаем nil, чтобы использовать стандартное меню
    }
    
    func textField(_ textField: UITextField, willPresentEditMenuWith animator: any UIEditMenuInteractionAnimating) {
        print("willPresentEditMenuWith Контекстное меню будет показано")
    }
    
    func textField(_ textField: UITextField, willDismissEditMenuWith animator: any UIEditMenuInteractionAnimating) {
        print("willDismissEditMenuWith Контекстное меню будет скрыто")
    }
}

