//
//  MyViewController.swift
//  programmatically
//
//  Created by Даниил Асташов on 07.01.2025.
//

import UIKit

class MyViewController: UIPageViewController {
    
    //MARK: - Variables
    var cars = [CarsHelper]()
    let cherry = UIImage(named: "cherry.jpg")
    let porshe = UIImage(named: "porshe.jpg")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Cars"
        
        let firstCar = CarsHelper(name: "car - cherry", image: cherry!)
        let secondCar = CarsHelper(name: "car - porshe", image: porshe!)
        cars.append(firstCar)
        cars.append(secondCar)
    }
    
    //MARK: - CreateVC
    lazy var arrayCarViewController: [CarViewController] = {
        var carsVC = [CarViewController]()
        for car in cars {
            carsVC.append(CarViewController(carWith: car))
        }
        return carsVC
    }()
    
    //MARK: - init UIPageViewController
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey: Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        self.view.backgroundColor = UIColor.green
        self.dataSource = self
        self.delegate = self
        setViewControllers([arrayCarViewController[0]], direction: .forward, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension MyViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController?{
        guard let viewController = viewController as? CarViewController else {return nil}
        if let index = arrayCarViewController.firstIndex(of: viewController){
            if index > 0 {
                return arrayCarViewController[index - 1]
            }
        }
        return nil
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController?{
        guard let viewController = viewController as? CarViewController else {return nil}
        if let index = arrayCarViewController.firstIndex(of: viewController){
            if index < cars.count - 1 {
                return arrayCarViewController[index + 1]
            }
        }
        return nil
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return cars.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
