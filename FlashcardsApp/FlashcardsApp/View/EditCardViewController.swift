import UIKit

class EditCardViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    private let viewModel: DeckDetailViewModel
    private let cardIndex: Int
    private var card: Card
    var onCardUpdated: (() -> Void)? // callback для обновления

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

    private func setupUI() {
        view.backgroundColor = .white
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

        let buttonStack = UIStackView(arrangedSubviews: [pickImageButton, removeImageButton])
        buttonStack.axis = .horizontal
        buttonStack.spacing = 10
        buttonStack.distribution = .fillEqually

        let stackView = UIStackView(arrangedSubviews: [frontTextField, backTextField, imageView, buttonStack, saveButton])
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
            saveButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    private func loadCardData() {
        frontTextField.text = card.frontText
        backTextField.text = card.backText
        if let imageData = card.imageData, let image = UIImage(data: imageData) {
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

        let newImageData = imageView.image?.jpegData(compressionQuality: 0.8)

        viewModel.updateCard(at: cardIndex, front: newFront, back: newBack, imageData: newImageData)
        onCardUpdated?()
        navigationController?.popViewController(animated: true)
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }
}

