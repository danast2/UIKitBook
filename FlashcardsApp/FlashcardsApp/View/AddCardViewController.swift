import UIKit

class AddCardViewController: UIViewController {
    private let viewModel: AddCardViewModel
    var onCardAdded: (() -> Void)? //замыкание для обновления UI
    
    private let frontTextField = UITextField()
    private let backTextField = UITextField()
    private let saveButton = UIButton()


    init(viewModel: AddCardViewModel) {
        self.viewModel = viewModel
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
        title = "Новая карточка"
        view.backgroundColor = .white

        frontTextField.placeholder = "Слово"
        frontTextField.borderStyle = .roundedRect

        backTextField.placeholder = "Перевод / Описание"
        backTextField.borderStyle = .roundedRect

        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.backgroundColor = .systemBlue
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

    @objc private func saveCard() {
        guard let frontText = frontTextField.text, !frontText.isEmpty,
              let backText = backTextField.text, !backText.isEmpty else {
            showErrorAlert(message: "Заполните оба поля!")
            return
        }

        viewModel.addCard(front: frontText, back: backText)
        
        // Уведомляем DeckDetailViewController, что карточка добавлена
        onCardAdded?()
        
        navigationController?.popViewController(animated: true)
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }
}

