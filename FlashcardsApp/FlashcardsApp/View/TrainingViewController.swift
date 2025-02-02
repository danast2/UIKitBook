
import UIKit

class TrainingViewController: UIViewController {
    private let viewModel: TrainingViewModel
    private let cardLabel = UILabel()
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
                
        cardLabel.font = .systemFont(ofSize: 24, weight: .bold)
        cardLabel.textAlignment = .center
        cardLabel.numberOfLines = 0
        
        showAnswerButton.setTitle("Показать ответ", for: .normal)
        showAnswerButton.backgroundColor = .systemGray
        showAnswerButton.addTarget(self, action: #selector(showAnswer), for: .touchUpInside)
        
        knownButton.setTitle("Запомнил", for: .normal)
        knownButton.backgroundColor = .systemGreen
        knownButton.isHidden = true
        knownButton.addTarget(self, action: #selector(markAsKnown), for: .touchUpInside)
        
        unknownButton.setTitle("Не запомнил", for: .normal)
        unknownButton.backgroundColor = .systemRed
        unknownButton.isHidden = true
        unknownButton.addTarget(self, action: #selector(markAsUnknown), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [cardLabel, showAnswerButton, knownButton, unknownButton])
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
