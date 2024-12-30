//
//  ViewController.swift
//  UISegmentedControl
//
//  Created by Даниил Асташов on 30.12.2024.
//

import UIKit

class ViewController: UIViewController {
    var segmentControll = UISegmentedControl()
    var imageView = UIImageView()
    let imageArray = [UIImage(named: "headphones.jpg"),
                      UIImage(named: "speaker.jpg"),
                      UIImage(named: "vinil.jpg")]
    var menuArray = ["one", "two", "three"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        self.imageView.center = self.view.center
        self.imageView.image = imageArray[0]
        self.view.addSubview(self.imageView)
        for (index, image) in imageArray.enumerated() {
            if image == nil {
                print("Image at index \(index) is nil")
            }
        }

        //create segment
        self.segmentControll  = UISegmentedControl(items: self.menuArray)
        self.segmentControll.frame = CGRect(x: 100, y: 700, width: 200, height: 30)
        self.view.addSubview(self.segmentControll)
        
        self.segmentControll.addTarget(self, action: #selector(changeImage(target:)), for: .valueChanged)
    }
    
    @objc
    func changeImage(target: UISegmentedControl) {
        if target == self.segmentControll{
            let segmentIndex = target.selectedSegmentIndex
            
            self.imageView.image = self.imageArray[segmentIndex]
            let pr = target.titleForSegment(at: segmentIndex)
            print(pr!)
        }
    }


}

