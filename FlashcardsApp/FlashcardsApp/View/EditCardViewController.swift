//
//  EditCardViewController.swift
//  FlashcardsApp
//
//  Created by Даниил Асташов on 02.02.2025.
//

import UIKit

class EditCardViewController: UIViewController {
    private let viewModel: DeckDetailViewModel
    private let cardIndex: Int
    private let card: Card
    var onCardUpdated: (() -> Void)? //добавляем callback
    
    private let frontTextField = UITextField()
    private let backTextField = UITextField()
    private let saveButton = UIButton()
    
    init(viewModel: DeckDetailViewModel, cardIndex: Int, card: Card) {
        self.viewModel = viewModel
        self.cardIndex = cardIndex
        self.card = card
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        title = "Редактировать карточку"
        
        frontTextField.borderStyle = .roundedRect
        frontTextField.text = card.frontText
        
        backTextField.borderStyle = .roundedRect
        backTextField.text = card.backText
        
        saveButton.setTitle("Cохранить", for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 8
        saveButton.addTarget(self, action: #selector(saveCard), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [frontTextField, backTextField, saveButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
    
    @objc private func saveCard(){
        guard let newFront = frontTextField.text, !newFront.isEmpty,
        let newBack = backTextField.text, !newBack.isEmpty else { return  }
        
        viewModel.editCard(at: cardIndex, front: newFront, back: newBack)
        onCardUpdated?() //Вызываем callback, чтобы уведомить DeckDetailViewController
        navigationController?.popViewController(animated: true)
    }
    
}
