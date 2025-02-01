
import UIKit
//import Charts
//import DGCharts

class SubscriptionListViewController: UIViewController, AddSubscriptionDelegate, SubscriptionDetailDelegate {
    
    //ViewModel для управления подписками
    private var viewModel = SubscriptionViewModel()
    
    //таблица для отображения подписок
    private let tableView = UITableView()
    
//    private let pieChartView: PieChartView = {
//        let chart = PieChartView()
//        chart.legend.enabled = false
//        chart.translatesAutoresizingMaskIntoConstraints = false
//        return chart
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isEditing = false //  По умолчанию отключено
        tableView.allowsSelectionDuringEditing = true //  Позволяет перемещать элементы
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
        
//        //добавляем график pie chart
//        view.addSubview(pieChartView)
//        NSLayoutConstraint.activate([
//            pieChartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//            pieChartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
//            pieChartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            pieChartView.heightAnchor.constraint(equalToConstant: 250)
//        ])
        
        //добавляю кнопку Добавить (+)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addSubscriptionTapped))
        //добавляю кнопку "изменить порядок"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Порядок", style: .plain, target: self, action: #selector(toggleEditingMode))
    }
    
//    private func updatePieChart() -> Void {
//        var entries: [PieChartDataEntry] = []
//        
//        for subscription in viewModel.subscriptions {
//            let entry = PieChartDataEntry(value: subscription.price, label: subscription.name)
//            entries.append(entry)
//        }
//        
//        let dataSet = PieChartDataSet(entries: entries)
//        dataSet.colors = ChartColorTemplates.material() // красивые цвета
//        let data = PieChartData(dataSet: dataSet)
//        
//        pieChartView.data = data
//    }
    
    //MARK: - режим редактирование подписок на главной странице
    @objc private func toggleEditingMode() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        navigationItem.leftBarButtonItem?.title = tableView.isEditing ? "Готово" : "Порядок"
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
        tableView.reloadData()
        //updatePieChart() // обновляем график
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
    
    //разрешаю перемещение ячеек
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //обрабатываю перемещение ячеек
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        viewModel.moveSubscription(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    // Разрешаем редактирование (перемещение)
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none // Отключаем стандартное удаление, чтобы было только перетаскивание
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
