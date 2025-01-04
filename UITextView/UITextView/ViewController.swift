//
//  ViewController.swift
//  UITextView
//
//  Created by Даниил Асташов on 04.01.2025.
//

import UIKit

class ViewController: UIViewController {
    
    var myTextView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createTextView()
    }

    func createTextView() {
        self.myTextView = UITextView(frame: CGRect(x: 20, y: 100, width: self.view.bounds.width - 50, height: self.view.bounds.height/2))
        self.myTextView.text = "smth"
        self.myTextView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        self.myTextView.font = UIFont.systemFont(ofSize: 17)
        self.myTextView.backgroundColor = .green
        self.view.addSubview(myTextView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.myTextView.resignFirstResponder()
        self.myTextView.backgroundColor = .white
    }
    
    @objc func updateTextView(param: Notification){
        let userInfo = param.userInfo
        
        let getKeyboardRect = (userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardFrame = self.view.convert(getKeyboardRect, to: view.window)
        
        if param.name == UIResponder.keyboardDidShowNotification{
            self.myTextView.contentInset = UIEdgeInsets.zero
        } else {
            self.myTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
            self.myTextView.scrollIndicatorInsets = self.myTextView.contentInset
        }
        self.myTextView.scrollRangeToVisible(myTextView.selectedRange)
    }
}

