//
//  CarViewController.swift
//  programmatically
//
//  Created by Даниил Асташов on 07.01.2025.
//

import UIKit

class CarViewController: UIViewController {
    
    //MARK: - Image
    private let carImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Label
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var subView: [UIView] = [self.carImage, self.nameLabel]
    
    //MARK: Init
    init(carWith: CarsHelper) {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .purple
        edgesForExtendedLayout = []
        
        carImage.image = carWith.image
        nameLabel.text = carWith.name
        
        for view in subView {
            self.view.addSubview(view)
        }
        
        NSLayoutConstraint.activate([
            // Constraints for carImage
            carImage.heightAnchor.constraint(equalToConstant: 250),
            carImage.widthAnchor.constraint(equalToConstant: 250),
            carImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            carImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            // Constraints for nameLabel
            nameLabel.topAnchor.constraint(equalTo: carImage.bottomAnchor, constant: 50),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
