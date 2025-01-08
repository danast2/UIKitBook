//
//  ViewController.swift
//  UISnapBehavior
//
//  Created by Даниил Асташов on 08.01.2025.
//

import UIKit

class ViewController: UIViewController {
    // UIAttachmentBehavior - привязка
    // UISnapBehavior - снимок

    var squareView = UIView()
    var animator = UIDynamicAnimator()
    var snapBehavior: UISnapBehavior?

    override func viewDidLoad() {
        super.viewDidLoad()
        createSmallSquareView()
        createAnimatorAndBehaviors()
        createTapGestureRecognizer()
    }

    // Создаем квадрат
    func createSmallSquareView() {
        squareView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        squareView.backgroundColor = UIColor.green
        squareView.center = view.center
        view.addSubview(squareView)
    }

    // Создаем анимации и поведения
    func createAnimatorAndBehaviors() {
        animator = UIDynamicAnimator(referenceView: view)
        
        // Столкновения
        let collision = UICollisionBehavior(items: [squareView])
        collision.translatesReferenceBoundsIntoBoundary = true
        
        // Начальная установка UISnapBehavior
        snapBehavior = UISnapBehavior(item: squareView, snapTo: squareView.center)
        snapBehavior?.damping = 0.5 // Средняя осцилляция

        animator.addBehavior(collision)
        if let snap = snapBehavior {
            animator.addBehavior(snap)
        }
    }

    // Добавляем распознаватель жестов
    func createTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        view.addGestureRecognizer(tapGestureRecognizer)
    }

    // Обработчик нажатий
    @objc func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        // Получаем точку нажатия
        let tapPoint = gesture.location(in: view)
        
        // Удаляем старое поведение
        if let snap = snapBehavior {
            animator.removeBehavior(snap)
        }
        
        // Добавляем новое поведение с новой точкой
        snapBehavior = UISnapBehavior(item: squareView, snapTo: tapPoint)
        snapBehavior?.damping = 0.5 // Средняя осцилляция
        if let snap = snapBehavior {
            animator.addBehavior(snap)
        }
    }
}

