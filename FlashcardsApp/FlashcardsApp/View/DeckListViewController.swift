

import UIKit

class DeckListViewController: UIViewController {
    private let tableView = UITableView()
    private let viewModel = DeckListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        title = "Мои Колоды"
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDeck))
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DeckCell")
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func addDeck(){
        let alert = UIAlertController(title: "Новая колода", message: "введите название", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Название"
        }
        let saveAction = UIAlertAction(title: "Создать", style: .default) { _ in
            if let name = alert.textFields?.first?.text, !name.isEmpty{
                self.viewModel.addDeck(name: name)
                self.tableView.reloadData()
            }
        }
        alert.addAction(saveAction)
        alert.addAction(UIAlertAction(title: "Отмена", style: .cancel))
        present(alert, animated: true)
    }
    
}


extension DeckListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.decks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DeckCell", for: indexPath)
        cell.textLabel?.text = viewModel.decks[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDeck = viewModel.decks[indexPath.row]
        let deckDetailVM = DeckDetailViewModel(deck: selectedDeck)
        
        //обновляем список колод при изменении карточек
        deckDetailVM.onDeckUpdated = { updatedDeck in
            self.viewModel.decks[indexPath.row] = updatedDeck
            self.tableView.reloadData() //обновляем список колод
        }
        
        let detailVC = DeckDetailViewController(viewModel: deckDetailVM)
        navigationController?.pushViewController(detailVC, animated: true)
    }

    
    
}
