import UIKit

class ViewController: UIViewController {
    
    var viewRed: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    var viewGreen: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Добавляем subviews
        view.addSubview(viewRed)
        view.addSubview(viewGreen)
        
        // Создаем метрики
        let metrics = ["height": 100, "width": view.bounds.size.width / 3, "top": 200]
        let viewVFL = ["viewRed": viewRed, "viewGreen": viewGreen]
        
        // Вертикальные ограничения
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[viewRed(height)]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: viewVFL))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[viewGreen(height)]",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: viewVFL))
        
        // Горизонтальные ограничения
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[viewRed(width)]-(50)-[viewGreen(width)]-|",
                                                           options: [],
                                                           metrics: metrics,
                                                           views: viewVFL))
    }
}

