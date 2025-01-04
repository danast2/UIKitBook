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
        print("Текстовое поле готово к редактированию")
        return true // Возвращаем true, чтобы разрешить редактирование
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Начато редактирование текстового поля")
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("Редактирование текстового поля скоро завершится")
        return true // Возвращаем true, чтобы разрешить завершение редактирования
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("Редактирование текстового поля завершено")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        switch reason {
        case .committed:
            print("Пользователь завершил редактирование (нажал Enter)")
        case .cancelled:
            print("Редактирование было отменено")
        @unknown default:
            print("Неизвестная причина завершения редактирования")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("Пользователь ввел символ: \(string)")
        return true // Возвращаем true, чтобы разрешить изменение текста
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        print("Изменился выбор текста")
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print("Текстовое поле будет очищено")
        return true // Возвращаем true, чтобы разрешить очистку
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Пользователь нажал Return")
        textField.resignFirstResponder() // Скрываем клавиатуру
        return true
    }
    
    func textField(_ textField: UITextField, editMenuForCharactersIn range: NSRange, suggestedActions: [UIMenuElement]) -> UIMenu? {
        print("Вызвано контекстное меню для выделенных символов")
        return nil // Возвращаем nil, чтобы использовать стандартное меню
    }
    
    func textField(_ textField: UITextField, willPresentEditMenuWith animator: any UIEditMenuInteractionAnimating) {
        print("Контекстное меню будет показано")
    }
    
    func textField(_ textField: UITextField, willDismissEditMenuWith animator: any UIEditMenuInteractionAnimating) {
        print("Контекстное меню будет скрыто")
    }
}

