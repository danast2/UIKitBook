import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - UI Elements
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person.circle")
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let themeSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Светлая", "Тёмная"])
        control.selectedSegmentIndex = UserDefaults.standard.integer(forKey: "selectedTheme") // Загружаем сохраненную тему
        return control
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        applyTheme() // Применяем сохраненную тему
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        title = "Профиль"
        view.backgroundColor = UIColor.systemBackground // Динамический цвет фона
        
        view.addSubview(profileImageView)
        view.addSubview(themeSegmentedControl)
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        themeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            themeSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            themeSegmentedControl.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            themeSegmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6)
        ])
        
        themeSegmentedControl.addTarget(self, action: #selector(themeChanged), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeProfileImage))
        profileImageView.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Theme Handling
    @objc private func themeChanged() {
        let selectedTheme = themeSegmentedControl.selectedSegmentIndex
        UserDefaults.standard.set(selectedTheme, forKey: "selectedTheme")
        
        applyTheme()
    }
    
    private func applyTheme() {
        let selectedTheme = UserDefaults.standard.integer(forKey: "selectedTheme")
        overrideUserInterfaceStyle = selectedTheme == 0 ? .light : .dark
        
        // Обновляем UI во всем приложении
        NotificationCenter.default.post(name: NSNotification.Name("themeChanged"), object: nil)
    }
    
    // MARK: - Profile Image Picker
    @objc private func changeProfileImage() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            profileImageView.image = image
        }
        picker.dismiss(animated: true)
    }
}

