//
//  ViewController.swift
//  UIScrollView & Bonus
//
//  Created by Даниил Асташов on 05.01.2025.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var myScrollView = UIScrollView()
    var myImageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        createScrollView()
    }
    // MARK: - UIScrollViewDelegate

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let p = "Начинается прокрутка"
        print(p)
        print(scrollView.contentOffset.y)
        self.myScrollView.alpha = 0.50
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let p = "Вызывается после прокрутки"
        print(p)
        self.myScrollView.alpha = 1.0
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let p = "Гарантирует, что вернет альфу к 1"
        print(p)
        self.myScrollView.alpha = 1.0
    }

    func createScrollView() {
        let imageToLoad = UIImage(named: "new_screen_for_UIImageView.png")
        self.myImageView = UIImageView(image: imageToLoad)
        self.myScrollView = UIScrollView(frame: self.view.bounds)
        self.myScrollView.addSubview(myImageView)
        self.myScrollView.contentSize = self.myImageView.bounds.size
        self.myScrollView.delegate = self
        self.view.addSubview(myScrollView)
    }

}

