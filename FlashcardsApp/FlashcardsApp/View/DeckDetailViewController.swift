
import UIKit

class DeckDetailViewController: UIViewController {
    
    private let tableView = UITableView()
    private let viewModel: DeckDetailViewModel
    
    init(viewModel: DeckDetailViewModel) {
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
    
    
    @objc private func startTraining() {
        let trainingVM = TrainingViewModel(deck: viewModel.deck)
        let trainingVC = TrainingViewController(viewModel: trainingVM)
        navigationController?.pushViewController(trainingVC, animated: true)
    }
    
    
    private func setupUI(){
        title = viewModel.deck.name
        view.backgroundColor = .white
        
        //включаем стандартную кнопку "назад"
        navigationItem.hidesBackButton = false
        
        // Переносим "Тренировку" на правую сторону
        navigationItem.rightBarButtonItems = [
           UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCard)),
           UIBarButtonItem(title: "Тренировка", style: .plain, target: self, action: #selector(startTraining))
        ]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCard))
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CardCell")
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func addCard(){
        let addCardVC = AddCardViewController(viewModel: viewModel)
        
        //передаем замыкание для обновления UI после возврата
        addCardVC.onCardAdded = {
            self.tableView.reloadData() //Перерисовываем список карточек
        }
        navigationController?.pushViewController(addCardVC, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension DeckDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCards().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath)
        let card = viewModel.getCards()[indexPath.row]
        cell.textLabel?.text = card.frontText
        return cell
    }
}

extension DeckDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteCard(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
