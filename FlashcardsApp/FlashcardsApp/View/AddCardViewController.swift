import UIKit

class AddCardViewController: UIViewController {
    private let viewModel: AddCardViewModel
    var onCardAdded: (() -> Void)?

    private let frontTextField = UITextField()
    private let backTextField = UITextField()
    private let saveButton = UIButton()
    private let imageView = UIImageView()
    private let addImageButton = UIButton()
    private var selectedImageData: Data?

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

        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.isHidden = true

        addImageButton.setTitle("Добавить фото", for: .normal)
        addImageButton.backgroundColor = .systemGray
        addImageButton.addTarget(self, action: #selector(selectImage), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [frontTextField, backTextField, addImageButton, imageView, saveButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }

    @objc private func saveCard() {
        guard let frontText = frontTextField.text, !frontText.isEmpty,
              let backText = backTextField.text, !backText.isEmpty else {
            showErrorAlert(message: "Заполните оба поля!")
            return
        }

        viewModel.addCard(front: frontText, back: backText, imageData: selectedImageData)

        onCardAdded?()
        navigationController?.popViewController(animated: true)
    }

    @objc private func selectImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }

    private func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }
}

extension AddCardViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
            imageView.isHidden = false
            selectedImageData = image.jpegData(compressionQuality: 0.8)
        }
        picker.dismiss(animated: true)
    }
}

