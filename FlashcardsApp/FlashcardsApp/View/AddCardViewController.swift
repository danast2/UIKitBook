import UIKit

class AddCardViewController: UIViewController {
    private let viewModel: AddCardViewModel
    var onCardAdded: (() -> Void)?
    private let unsplashService = UnsplashService() // Сервис для получения URL картинки

    private let frontTextField = UITextField()
    private let backTextField = UITextField()
    private let saveButton = UIButton()
    private let imageView = UIImageView()
    private let addImageButton = UIButton()
    private let generateImageButton = UIButton()
    private var selectedImagePath: String? // Сохраняем путь к файлу с изображением

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let selectedTheme = UserDefaults.standard.integer(forKey: "selectedTheme")
        overrideUserInterfaceStyle = selectedTheme == 0 ? .light : .dark
    }

    private func setupUI() {
        title = "Новая карточка"
        view.backgroundColor = UIColor.systemBackground

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

        generateImageButton.setTitle("Сгенерировать изображение", for: .normal)
        generateImageButton.backgroundColor = .systemBlue
        generateImageButton.setTitleColor(.white, for: .normal)
        generateImageButton.layer.cornerRadius = 10
        generateImageButton.addTarget(self, action: #selector(generateImage), for: .touchUpInside)

        let stackView = UIStackView(
            arrangedSubviews: [
                frontTextField,
                backTextField,
                addImageButton,
                generateImageButton,
                imageView,
                saveButton
            ]
        )
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

    @objc private func generateImage() {
        guard let word = frontTextField.text, !word.isEmpty else {
            showErrorAlert(message: "Введите слово перед генерацией изображения!")
            return
        }

        // 1. Запрашиваем URL изображения с Unsplash
        unsplashService.fetchImage(for: word) { [weak self] imageURLString in
            guard let self = self else { return }
            guard
                let urlString = imageURLString,
                let url = URL(string: urlString)
            else {
                DispatchQueue.main.async {
                    self.showErrorAlert(message: "Не удалось получить URL изображения")
                }
                return
            }

            // 2. Скачиваем картинку по полученному URL
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard
                    let data = data,
                    error == nil,
                    let downloadedImage = UIImage(data: data)
                else {
                    DispatchQueue.main.async {
                        self.showErrorAlert(message: "Не удалось скачать изображение")
                    }
                    return
                }

                // 3. Сохраняем изображение в локальное хранилище
                DispatchQueue.main.async {
                    self.imageView.isHidden = false
                    if let imagePath = LocalStorageService().saveImage(downloadedImage) {
                        self.selectedImagePath = imagePath
                        self.imageView.image = downloadedImage
                    } else {
                        self.showErrorAlert(message: "Ошибка сохранения изображения")
                    }
                }
            }.resume()
        }
    }

    @objc private func saveCard() {
        guard
            let frontText = frontTextField.text, !frontText.isEmpty,
            let backText = backTextField.text, !backText.isEmpty
        else {
            showErrorAlert(message: "Заполните оба поля!")
            return
        }

        viewModel.addCard(
            front: frontText,
            back: backText,
            imagePath: selectedImagePath
        ) // Передаём путь к изображению
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
        let alert = UIAlertController(
            title: "Ошибка",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension AddCardViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
            imageView.isHidden = false
            selectedImagePath = LocalStorageService().saveImage(image)
        }
        picker.dismiss(animated: true)
    }
}

