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
        
        // Устанавливаем ограничения
        createViewRedConstrait()
        createViewGreenConstrait()
    }
    
    func createViewRedConstrait() {
        viewRed.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        viewRed.widthAnchor.constraint(equalToConstant: 200).isActive = true
        viewRed.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
        viewRed.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func createViewGreenConstrait() {
        viewGreen.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        viewGreen.widthAnchor.constraint(equalToConstant: 200).isActive = true
        viewGreen.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3).isActive = true
        viewGreen.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

