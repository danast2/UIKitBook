
import UIKit

class SubscriptionListViewController: UIViewController {

//setupUI - Cоздаёт интерфейс с UITableView. +
//loadSubscriptions() - Загружает подписки из SubscriptionViewModel +
//addSubscriptionTapped() - Открывает экран добавления подписки. AddSubscriptionViewController.swift +
//deleteSubscription(at:) - Удаляет подписку свайпом влево. +
//editSubscription() - редактирует подписку с помощью SubscriptionDetailViewController.swift ???
    
    //ViewModel для управления подписками
    private var viewModel = SubscriptionViewModel()
    
    //таблица для отображения подписок
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadSubscriptions()
    }
    
    //MARK: - настройка UI
    private func setupUI(){
        title = "Мои Подписки"
        view.backgroundColor = .white
        
        //настройка таблицы
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SubscriptionCell")
        view.addSubview(tableView)
        
        //добавляю кнопку Добавить
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSubscriptionTapped))
    }
    
    //MARK: - загрузка подписок
    private func loadSubscriptions(){
        viewModel.loadSubscription()
        tableView.reloadData() //MARK: - ?
    }
    
    //MARK: - открытие экрана добавления подписки
    @objc private func addSubscriptionTapped(){
        let addVC = AddSubscriptionViewController()
        navigationController?.pushViewController(addVC, animated: true)
    }
}

//MARK: - UITableView DataSource & Delegate
extension SubscriptionListViewController: UITableViewDataSource, UITableViewDelegate{
    
    //обязательный метод - кол-во строк
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.subscriptions.count
    }
    
    //обязательный метод - заполнение ячеек данными
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubscriptionCell", for: indexPath)
        let subscription = viewModel.subscriptions[indexPath.row]
        
        cell.textLabel?.text = "\(subscription.name) - \(subscription.price) ₽"
        cell.detailTextLabel?.text = "Списания: \(subscription.renewalDate)"
        
        return cell
    }
    
    //удаление подписки свайпом влево
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeSubscription(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
