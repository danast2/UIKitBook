//
//  ViewController.swift
//  UINavigationViewController_part_2
//
//  Created by Даниил Асташов on 03.01.2025.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.rightBarButtonItem =  UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(perfAdd(param:)))
        
//        let simpleSwitch = UISwitch()
//        simpleSwitch.isOn = true
//        simpleSwitch.addTarget(self, action: #selector(switchIsChange(param:)), for: .valueChanged)
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: simpleSwitch)
        
        self.title = "View Controller"
        
        let items = ["up", "down"]
        
        let segmentController = UISegmentedControl(items: items)
        //segmentController.isMomentary = true
        segmentController.addTarget(self, action: #selector(segmentControllHandler(param:)), for: .valueChanged)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: segmentController)
    }
    
    @objc func segmentControllHandler(param: UISegmentedControl){
        switch param.selectedSegmentIndex {
        case 0:
            print("up")
        case 1:
            print("down")
        default:
            break
        }
    }
    
    @objc func switchIsChange(param: UISwitch){
        if param.isOn {
            print("Switch is on")
        }else{
            print("Switch is off")
        }
    }
    
    
    //MARK: - Method
//    @objc func perfAdd(param: UIBarButtonItem) {
//        print("Add click")
//    }
//    
    //MARK: - создана с помощью пкм (Refactor -> Extract to Method)
//    fileprivate func createImageTitleView() {
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
//        //поможет правильно отображать (чтобы не было странного растяжения)
//        imageView.contentMode = .scaleAspectFit
//        let image = UIImage(named: "headphones.jpg")
//        imageView.image = image
//        self.navigationItem.titleView = imageView
//    }

}

