//
//  TrainingViewController.swift
//  FlashcardsApp
//
//  Created by Даниил Асташов on 01.02.2025.
//

import UIKit

class TrainingViewController: UIViewController {
    private let viewModel: TrainingViewModel
    private let cardLabel = UILabel()
    private let rememberedButton = UIButton()
    private let difficultButton = UIButton()
    
    init(viewModel: TrainingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateCard()
    }
    
    private func setupUI(){
        title = "Тренировка"
        view.backgroundColor = .white
                
        cardLabel.font = .systemFont(ofSize: 24, weight: .bold)
        cardLabel.textAlignment = .center
        cardLabel.numberOfLines = 0
        
        rememberedButton.setTitle("Запомнил", for: .normal)
        rememberedButton.backgroundColor = .systemGreen
        rememberedButton.addTarget(self, action: #selector(markAsRemembered), for: .touchUpInside)
        
        difficultButton.setTitle("Сложно", for: .normal)
        difficultButton.backgroundColor = .systemRed
        difficultButton.addTarget(self, action: #selector(markAsDifficult), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [cardLabel, rememberedButton, difficultButton])
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
    
    private func updateCard(){
        if let card = viewModel.currentCard {
            cardLabel.text = card.frontText
        } else {
            showCompletionMessage()
        }
    }
    
    @objc private func markAsRemembered() {
        viewModel.markAsRemembered()
        updateCard()
    }
    
    @objc private func markAsDifficult() {
        viewModel.markAsDifficult()
        updateCard()
    }
    
    private func showCompletionMessage() {
        cardLabel.text = "Все слова повторены!"
        rememberedButton.isHidden = true
        difficultButton.isHidden = true
    }

}
