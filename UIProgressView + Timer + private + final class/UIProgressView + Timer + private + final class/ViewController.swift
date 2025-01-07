//
//  ViewController.swift
//  UIProgressView + Timer + private + final class
//
//  Created by Даниил Асташов on 07.01.2025.
//

import UIKit

class ViewController: UIViewController {
    
    var myProgressView = UIProgressView()
    var myTime = Timer()
    var myButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createProgress(myProgressView)
        self.createButton(myButton)
        self.createTimer()
    }
    
    //MARK: Time
    func createTimer() {
        myTime = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateProgressView), userInfo: nil, repeats: true)
    }

    
    
    //MARK: Selector
    @objc func updateProgressView() {
        if myProgressView.progress != 1.0{
            myProgressView.progress += 0.1 / 1.0
        } else if myProgressView.progress == 1.0{
            UIView.animate(withDuration: 0.7, animations: {
                self.myButton.alpha = 1
                self.myButton.setTitle("Старт", for: .normal)
                self.myTime.invalidate()
            })
        }
    }
    
    //MARK: - UI
    func createProgress(_ progressView: UIProgressView) {
        progressView.progressViewStyle = .bar
        progressView.frame = CGRect(x: Int(self.view.center.x), y: Int(self.view.center.y), width: 150, height: 50)
        progressView.setProgress(0.0, animated: true)
        progressView.progressTintColor = .cyan
        progressView.trackTintColor = .darkText
        progressView.center = self.view.center
        view.addSubview(progressView)
    }
    
    func createButton(_ button: UIButton) {
        button.frame = CGRect(x: view.bounds.size.width / 4, y: view.center.y + 100, width: 150, height: 50)
        button.alpha = 0.2
        button.setTitle("загрузка", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .darkGray
        view.addSubview(button)
    }
}

