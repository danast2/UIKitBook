
import UIKit

class DeckDetailViewController: UIViewController {
    
    private let tableView = UITableView()
    private let viewModel: DeckDetailViewModel
    var onDeckDeleted: (() -> Void)? // Callback для обновления списка колод
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let selectedTheme = UserDefaults.standard.integer(forKey: "selectedTheme")
        overrideUserInterfaceStyle = selectedTheme == 0 ? .light : .dark
    }

    
    
    @objc private func startTraining() {
        let trainingVM = TrainingViewModel(deck: viewModel.deck)
        let trainingVC = TrainingViewController(viewModel: trainingVM)
        navigationController?.pushViewController(trainingVC, animated: true)
    }
    
    private let deleteDeckButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Удалить колоду", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private func setupUI(){
        title = viewModel.deck.name
        view.backgroundColor = UIColor.systemBackground
        
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
        tableView.register(CardCell.self, forCellReuseIdentifier: CardCell.identifier)
        
        view.addSubview(tableView)
        view.addSubview(deleteDeckButton) //кнопка удаления колоды
        
        deleteDeckButton.addTarget(self, action: #selector(deleteDeck), for: .touchUpInside)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: deleteDeckButton.topAnchor, constant: -16),

            deleteDeckButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteDeckButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            deleteDeckButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            deleteDeckButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc private func addCard(){
        let addCardVM = AddCardViewModel(deck: viewModel.deck) //передаем колоду
        let addCardVC = AddCardViewController(viewModel: addCardVM)
        
        //передаем замыкание для обновления UI после возврата
        addCardVC.onCardAdded = {
            self.viewModel.updateDeck()
            self.tableView.reloadData() //Перерисовываем список карточек
        }
        navigationController?.pushViewController(addCardVC, animated: true)
    }
    
    @objc private func deleteDeck() {
        let alert = UIAlertController(title: "Удалить колоду?", message: "Вы уверены, что хотите удалить всю колоду?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Удалить", style: .destructive) { [weak self] _ in
            guard let self = self else { return }
            
            // Удаляем колоду через viewModel
            self.viewModel.deleteDeck()
            
            // Сообщаем `DeckListViewController`, что колода удалена
            self.onDeckDeleted?()
            
            // Возвращаемся в список колод
            self.navigationController?.popViewController(animated: true)
        })
        
        present(alert, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension DeckDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCards().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.identifier, for: indexPath) as! CardCell
        let card = viewModel.getCards()[indexPath.row]
        cell.configure(with: card)
        return cell
    }
}

extension DeckDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let card = viewModel.getCards()[indexPath.row] // Получаем карточку
            viewModel.deleteCard(withId: card.id) // Удаляем карточку по ID

            // Обновляем данные
            tableView.performBatchUpdates({
                tableView.deleteRows(at: [indexPath], with: .fade)
            }, completion: { _ in
                self.tableView.reloadData() // Перезагружаем, чтобы индексы обновились
            })
        }
    }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let card = viewModel.getCards()[indexPath.row]
        let editVC = EditCardViewController(viewModel: viewModel, cardIndex: indexPath.row, card: card)

        editVC.onCardUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }

        editVC.onCardDeleted = { [weak self] in
            guard let self = self else { return }
            self.viewModel.deleteCard(withId: card.id) // Теперь удаляем по ID
            self.tableView.reloadData()
            self.navigationController?.popViewController(animated: true)
        }

        navigationController?.pushViewController(editVC, animated: true)
    }


}
