//
//  ViewController.swift
//  UIActivityViewController
//
//  Created by Даниил Асташов on 01.01.2025.
//

import UIKit

class ViewController: UIViewController {
    var buttonShare = UIButton()
    var textField = UITextField()
    var activityViewController: UIActivityViewController? = nil
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.createTextField()
        self.createButton()
    }
    //MARK: - Method
    func createTextField(){
        self.textField.frame = CGRect(x: 0, y: 0, width: 280, height: 30)
        self.textField.center = self.view.center
        self.textField.borderStyle = UITextField.BorderStyle.roundedRect
        self.textField.placeholder = "enter text to share"
        self.view.addSubview(self.textField)
    }
    
    func createButton(){
        self.buttonShare = UIButton(type: .roundedRect)
        self.buttonShare.frame = CGRect(x: 50, y: 350, width: 280, height: 44)
        self.buttonShare.setTitle("Share", for: .normal)
        self.buttonShare.addTarget(self, action: #selector(handleShare(paramSender:)), for: .touchUpInside)
        self.view.addSubview(self.buttonShare)
    }
    
    @objc
    func handleShare(paramSender: Any){
        guard let text = self.textField.text, !text.isEmpty else{
            let message = "Сначала введите текст, потом нажмите кнопку"
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        self.activityViewController = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        self.present(self.activityViewController!, animated: true, completion: nil)
    }
}

