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
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 40))
        //поможет правильно отображать (чтобы не было странного растяжения)
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "headphones.jpg")
        imageView.image = image
        self.navigationItem.titleView = imageView
    }


}

