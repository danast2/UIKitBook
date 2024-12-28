//
//  ViewController.swift
//  UIPickerView
//
//  Created by Даниил Асташов on 28.12.2024.
//

import UIKit

class ViewController: UIViewController {
    
    let picker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.center = self.view.center
        self.picker.datePickerMode = .countDownTimer
        
        self.view.addSubview(picker)
        var oneYearTime = TimeInterval()
        oneYearTime = 365 * 24 * 60 * 60
        
        let todayDate = Date()
        let oneYearFromToday = todayDate.addingTimeInterval(oneYearTime)
        let twoYearFromToday = todayDate.addingTimeInterval(oneYearTime * 2)
        
        picker.minimumDate = oneYearFromToday
        picker.maximumDate = twoYearFromToday
        
        picker.countDownDuration = 2 * 60
        
        self.picker.addTarget(self, action: #selector(datePickerChange(paramDatePicker: )), for: .valueChanged)
    }
    
    @objc
    func datePickerChange(paramDatePicker: UIDatePicker){
        if paramDatePicker.isEqual(self.picker){
            print("data change = ", paramDatePicker.date)
        }
    }

}
