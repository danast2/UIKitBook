//
//  ViewController.swift
//  UIattachmentBehavior
//
//  Created by Даниил Асташов on 08.01.2025.
//

import UIKit

class ViewController: UIViewController {
    // UIAttachmentBehavior - привязка
    // UISnapBehavior - снимок

    var squareView = UIView()
    var squareViewAnchorView = UIView()
    var anchorView = UIView()
    var animator = UIDynamicAnimator()
    var attachmentBehavior: UIAttachmentBehavior?

    override func viewDidLoad() {
        super.viewDidLoad()
        createSmallSquareView()
    }

    // Создаем квадрат и в нем еще один
    func createSmallSquareView() {
        squareView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        squareView.backgroundColor = UIColor.green
        squareView.center = view.center
        
        squareViewAnchorView = UIView(frame: CGRect(x: 60, y: 0, width: 20, height: 20))
        squareViewAnchorView.backgroundColor = UIColor.brown
        squareView.addSubview(squareViewAnchorView)
        
        view.addSubview(squareView)
    }

    // View с точкой привязки
    func createAnchorView() {
        anchorView = UIView(frame: CGRect(x: 120, y: 120, width: 20, height: 20))
        anchorView.backgroundColor = UIColor.red
        view.addSubview(anchorView)
    }


}

