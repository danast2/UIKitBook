
import UIKit

class SubscriptionListViewController: UIViewController, AddSubscriptionDelegate, SubscriptionDetailDelegate {

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
        tableView.register(SubscriptionCell.self, forCellReuseIdentifier: SubscriptionCell.identifier)
        tableView.estimatedRowHeight = 150 //фиксируем высоту ячеек - пока не работает
        tableView.rowHeight = UITableView.automaticDimension //(в случае чего, они сами адаптируются) - пока не работает
        view.addSubview(tableView)
        
        //добавляю кнопку Добавить (+)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSubscriptionTapped))
    }
    
    //MARK: - открытие экрана добавления подписки
    @objc private func addSubscriptionTapped(){
        let addVC = AddSubscriptionViewController()
        addVC.delegate = self //  Устанавливаем делегат для AddSubscriptionViewController
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    //MARK: - загрузка подписок
    private func loadSubscriptions(){
        viewModel.loadSubscription()
    }
    
}

//MARK: - UITableView DataSource & Delegate
extension SubscriptionListViewController: UITableViewDataSource, UITableViewDelegate{
    
    //обязательный метод (UITableViewDataSource) - кол-во строк
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.subscriptions.count
    }
    
    //обязательный метод (UITableViewDataSource) - заполнение ячеек данными
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SubscriptionCell.identifier, for: indexPath) as? SubscriptionCell else {
            return UITableViewCell()
        }
        
        let subscription = viewModel.subscriptions[indexPath.row]
        cell.configure(with: subscription)
        return cell
    }

    
    //удаление подписки свайпом влево
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removeSubscription(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //экран изменения значений подписки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedSubscription = viewModel.subscriptions[indexPath.row]
        let detailVC = SubscriptionDetailViewController(subscription: selectedSubscription)
        detailVC.delegate = self //устанавливаю делегат
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - AddSubscriptionDelegate Делегат, обновляющий список подписок
    func didAddSubscription(_ subscription: Subscription) {
        viewModel.addSubscription(subscription) 
        tableView.reloadData()
    }
    
    //MARK: - SubscriptionDetailDelegate
    func didDeleteSubscription(_ subscriptionID: UUID) -> Void {
        viewModel.removeSubscriptionByID(subscriptionID) //удаляем подписку из viewModel
        tableView.reloadData() // обновляем таблицу
    }
    
    func didUpdateSubscription(_ subscription: Subscription) -> Void {
        viewModel.updateSubscription(subscription) // обновляем подписку в viewModel
        tableView.reloadData() // обновляем таблицу
    }
    
}
