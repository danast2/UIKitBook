//
//  ViewController.swift
//  UIPushBehavior
//
//  Created by Даниил Асташов on 08.01.2025.
//

import UIKit

class ViewController: UIViewController {
    //UICollisionBehavior – обнаружение столкновений
    //UIGravityBehavior – обеспечивает тяготение
    //UIPushBehavior – реагирует на толчки
    //UISnapBehavior – крепит view к определенной точке
    
    var squareViews = [UIDynamicItem]()
    var animator = UIDynamicAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //создаем view
        
        let numberOfView = 2
        squareViews.reserveCapacity(numberOfView)
        var colors = [UIColor.red, UIColor.green]
        var currentCenterPoint: CGPoint = view.center
        let eachViewSize = CGSize(width: 50, height: 50)
        
        for counter in 0..<numberOfView {
            let newView = UIView(frame: CGRect(x: 0, y: 0, width: eachViewSize.width, height: eachViewSize.height))
            newView.backgroundColor = colors[counter]
            newView.center = currentCenterPoint
            currentCenterPoint.y += eachViewSize.height + 10
            view.addSubview(newView)
            squareViews.append(newView)
        }
        
        animator = UIDynamicAnimator(referenceView: view)
        
        //создадим тяготение
        let gravity = UIGravityBehavior(items: squareViews)
        animator.addBehavior(gravity)
        
        //реализуем столкновение
        let collision = UICollisionBehavior(items: squareViews)
        collision.translatesReferenceBoundsIntoBoundary = true
        
        collision.addBoundary(withIdentifier: "bottomBoundary" as NSCopying, from: CGPoint(x: 0, y: view.bounds.size.height - 100), to: CGPoint(x: view.bounds.size.width, y: view.bounds.size.height - 100))
        
        animator.addBehavior(collision)
        
//        //создаем квадрат
//        squareView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        squareView.backgroundColor = .black
//        squareView.center = view.center
//        view.addSubview(squareView)
//        
//        //создаем animator и тяготение
//        animator = UIDynamicAnimator(referenceView: view)
//        let gravity = UIGravityBehavior(items: [squareView])
//        animator.addBehavior(gravity)
    }

}

