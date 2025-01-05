//
//  ViewController.swift
//  UIImageView & UIImage
//
//  Created by Даниил Асташов on 05.01.2025.
//

import UIKit

class ViewController: UIViewController {
    
    var myImageView = UIImageView()
    let macBookImage = UIImage(named: "new_screen_for_UIImageView.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myImageView = UIImageView(frame: self.view.bounds)
        self.myImageView.contentMode = .scaleAspectFit
        self.myImageView.image = macBookImage
        //self.myImageView = UIImageView(image: macBookImage)
        self.myImageView.center = self.view.center
        view.addSubview(self.myImageView)
    }


}

