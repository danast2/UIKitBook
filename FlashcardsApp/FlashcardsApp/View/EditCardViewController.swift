import UIKit

class EditCardViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private let viewModel: DeckDetailViewModel
    private let cardIndex: Int
    private var card: Card
    var onCardUpdated: (() -> Void)? // callback для обновления
    var onCardDeleted: (() -> Void)? // callback для удаления карточки

    private let frontTextField = UITextField()
    private let backTextField = UITextField()
    private let imageView = UIImageView()
    private let pickImageButton = UIButton()
    private let removeImageButton = UIButton()
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
        loadCardData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let selectedTheme = UserDefaults.standard.integer(forKey: "selectedTheme")
        overrideUserInterfaceStyle = selectedTheme == 0 ? .light : .dark
    }

    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Удалить карточку", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private func setupUI() {
        view.backgroundColor = UIColor.systemBackground
        title = "Редактировать карточку"

        frontTextField.borderStyle = .roundedRect
        backTextField.borderStyle = .roundedRect

        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        pickImageButton.setTitle("Выбрать изображение", for: .normal)
        pickImageButton.backgroundColor = .systemBlue
        pickImageButton.setTitleColor(.white, for: .normal)
        pickImageButton.layer.cornerRadius = 8
        pickImageButton.addTarget(self, action: #selector(pickImage), for: .touchUpInside)

        removeImageButton.setTitle("Удалить изображение", for: .normal)
        removeImageButton.backgroundColor = .systemRed
        removeImageButton.setTitleColor(.white, for: .normal)
        removeImageButton.layer.cornerRadius = 8
        removeImageButton.addTarget(self, action: #selector(removeImage), for: .touchUpInside)

        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.backgroundColor = .systemGreen
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 8
        saveButton.addTarget(self, action: #selector(saveCard), for: .touchUpInside)
        
        deleteButton.addTarget(self, action: #selector(deleteCard), for: .touchUpInside)

        let buttonStack = UIStackView(arrangedSubviews: [pickImageButton, removeImageButton])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 10
        buttonStack.distribution = .fillEqually

        let stackView = UIStackView(arrangedSubviews: [frontTextField, backTextField, imageView, buttonStack, saveButton, deleteButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),

            imageView.heightAnchor.constraint(equalToConstant: 150),
            pickImageButton.heightAnchor.constraint(equalToConstant: 44),
            removeImageButton.heightAnchor.constraint(equalToConstant: 44),
            saveButton.heightAnchor.constraint(equalToConstant: 44),
            deleteButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func loadCardData() {
        frontTextField.text = card.frontText
        backTextField.text = card.backText
        
        if let imagePath = card.imagePath, let image = LocalStorageService().loadImage(from: imagePath) {
            imageView.image = image
            imageView.isHidden = false
            removeImageButton.isHidden = false
        } else {
            imageView.isHidden = true
            removeImageButton.isHidden = true
        }
    }


    @objc private func pickImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }

    @objc private func removeImage() {
        imageView.image = nil
        imageView.isHidden = true
        removeImageButton.isHidden = true
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
            imageView.isHidden = false
            removeImageButton.isHidden = false
        }
        picker.dismiss(animated: true)
    }

    @objc private func saveCard() {
        guard let newFront = frontTextField.text, !newFront.isEmpty,
              let newBack = backTextField.text, !newBack.isEmpty else {
            showErrorAlert(message: "Заполните оба текстовых поля!")
            return
        }

        let newImage = imageView.image
        viewModel.updateCard(at: cardIndex, front: newFront, back: newBack, image: newImage)

        onCardUpdated?()
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func deleteCard(){
        let alert = UIAlertController(title: "Удалить карточку?", message: "Вы уверены, что хотите удалить эту карточку?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive){ [weak self] _ in
            guard let self = self else { return }
            self.viewModel.deleteCard(withId: self.card.id) // Удаляем карточку по ID
            self.onCardDeleted?() // Вызываем callback для обновления UI

            // Вместо popViewController используем popToViewController, чтобы гарантированно остаться в DeckDetailViewController
            if let deckDetailVC = self.navigationController?.viewControllers.first(where: { $0 is DeckDetailViewController }) {
                self.navigationController?.popToViewController(deckDetailVC, animated: true)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        })
        present(alert, animated: true)
    }



    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }
}

