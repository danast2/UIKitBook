import UIKit

class TrainingViewController: UIViewController {
    private let viewModel: TrainingViewModel
    private let showAnswerButton = UIButton()
    private let knownButton = UIButton()
    private let unknownButton = UIButton()
    
    init(viewModel: TrainingViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cardLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Подписываемся на окончание тренировки
        viewModel.onTrainingEnd = { [weak self] in
            DispatchQueue.main.async {
                self?.showTrainingEndAlert()
            }
        }
        
        updateCard()
    }
    
    private func setupUI(){
        title = "Тренировка"
        view.backgroundColor = .white
                
        configureButton(showAnswerButton, title: "Показать ответ", backgroundColor: .systemGray)
        configureButton(knownButton, title: "Запомнил", backgroundColor: .systemGreen)
        configureButton(unknownButton, title: "Не запомнил", backgroundColor: .systemRed)
        
        showAnswerButton.addTarget(self, action: #selector(showAnswer), for: .touchUpInside)
        knownButton.addTarget(self, action: #selector(markAsKnown), for: .touchUpInside)
        unknownButton.addTarget(self, action: #selector(markAsUnknown), for: .touchUpInside)
        
        view.addSubview(cardView)
        cardView.addSubview(cardLabel)
        
        let stackView = UIStackView(arrangedSubviews: [showAnswerButton, knownButton, unknownButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            cardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cardView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            cardView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            
            cardLabel.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            cardLabel.centerYAnchor.constraint(equalTo: cardView.centerYAnchor),
            cardLabel.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.8),
            
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 20),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
        
    }
    
    private func configureButton(_ button: UIButton, title: String, backgroundColor: UIColor) {
        button.setTitle(title, for: .normal)
        button.backgroundColor = backgroundColor
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func updateCard() {
        // Если тренировка закончилась
        if viewModel.isTrainingFinished {
            showTrainingEndAlert()
            return
        }

        // Если карточек нет вообще (изначально пустая колода)
        if !viewModel.hasTrainingCards {
            showNoCardsAlert()
            return
        }

        // Обновляем карточку, если есть текущая
        if let card = viewModel.getCurrentCard() {
            UIView.transition(with: cardView, duration: 0.3, options: .transitionFlipFromRight, animations: {
                self.cardLabel.text = card.frontText
            }, completion: nil)
            cardLabel.text = card.frontText
            showAnswerButton.isHidden = false
            knownButton.isHidden = true
            unknownButton.isHidden = true
        }
    }
    
    private func showNoCardsAlert() {
        let alert = UIAlertController(
            title: "Нет карточек",
            message: "Добавьте хотя бы одну карточку, чтобы начать тренировку",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }
    
    private func showTrainingEndAlert() {
        let alert = UIAlertController(
            title: "Тренировка",
            message: "Вы повторили все карточки",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        })
        present(alert, animated: true)
    }
    
    @objc private func showAnswer() {
        guard let card = viewModel.getCurrentCard() else { return }
        cardLabel.text = card.backText
        
        showAnswerButton.isHidden = true
        knownButton.isHidden = false
        unknownButton.isHidden = false
    }
    
    @objc private func markAsKnown() {
        viewModel.markAsKnown()
        updateCard()
    }
    
    @objc private func markAsUnknown() {
        viewModel.markAsUnknown()
        updateCard()
    }
}

