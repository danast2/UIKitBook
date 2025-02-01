
import UIKit

class SubscriptionDetailViewController: UIViewController {
    
    private var subscription: Subscription
    private let viewModel = SubscriptionViewModel()
    
    weak var delegate: SubscriptionDetailDelegate?
    
    private let nameField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let priceField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .decimalPad
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        return picker
    }()
    
    private let cycleSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Месяц", "Год", "Неделя", "Полгода", "Полмесяца"])
        return control
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сохранить", for: .normal)
        button.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Удалить", for: .normal)
        button.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Инициализация контроллера
    init(subscription: Subscription) {
        self.subscription = subscription
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setupTapGesture()
        setupUI()
        loadSubscriptionData()
    }
    
    private func setupUI(){
        title = "Редактировать подписку"
        view.backgroundColor = .white
        
        let stackView = UIStackView(arrangedSubviews: [nameField, priceField, datePicker, cycleSegmentedControl, saveButton, deleteButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     stackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
                                 ])
    }
    
    private func setupTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard(){
        view.endEditing(true)
    }
    
    
    //MARK: - Загрузка данных подписки
    private func loadSubscriptionData(){
        nameField.text = subscription.name
        priceField.text = "\(subscription.price)"
        datePicker.date = subscription.renewalDate
        
        switch subscription.cycle{
        case .monthly: cycleSegmentedControl.selectedSegmentIndex = 0
        case .yearly: cycleSegmentedControl.selectedSegmentIndex = 1
        case .weekly: cycleSegmentedControl.selectedSegmentIndex = 2
        case .halfOfYear: cycleSegmentedControl.selectedSegmentIndex = 3
        case .halfOfMonth: cycleSegmentedControl.selectedSegmentIndex = 4
        }
    }
    
    //MARK: - Сохранение изменений
    @objc private func saveTapped(){
        guard let name = nameField.text, !name.isEmpty,
              let priceText = priceField.text, let price = Double(priceText) else {
            showErrorAlert(message: "Введите корректные данные")
            return
        }
        
        let selectedCycle: BillingCycle
        switch cycleSegmentedControl.selectedSegmentIndex{
        case 0: selectedCycle = .monthly
        case 1: selectedCycle = .yearly
        case 2: selectedCycle = .weekly
        case 3: selectedCycle = .halfOfYear
        case 4: selectedCycle = .halfOfMonth
        default: selectedCycle = .monthly
        }
        
        subscription = Subscription(
            id: subscription.id, name: name, price: price, renewalDate: datePicker.date, cycle: selectedCycle, paymentMethod: "Карта")
        
        delegate?.didUpdateSubscription(subscription) // уведомляет делегата об изменении
        viewModel.updateSubscription(subscription)
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Удаление подписки
    @objc private func deleteTapped(){
        delegate?.didDeleteSubscription(subscription.id) //уведомляет делегата об удалении
        viewModel.removeSubscriptionByID(subscription.id) //удаляем из хранилища
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - показ ошибки
    private func showErrorAlert(message: String){
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }
}
