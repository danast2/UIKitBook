import UIKit

class ViewController: UIViewController {
    let tableViewController = UITableViewController(style: .plain)
    var refresh = UIRefreshControl()
    
    var allTime = [Date]()
    var cellIdentefier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTableView()
        
        self.refresh.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        self.refresh.tintColor = .red
        
        view.addSubview(tableViewController.tableView)
        tableViewController.tableView.addSubview(refresh)
    }
    
    @objc func handleRefresh(){
        allTime.append(Date())
        refresh.endRefreshing()
        let indexPathNewRow = IndexPath(row: allTime.count - 1, section: 0)
        tableViewController.tableView.insertRows(at: [indexPathNewRow], with: .automatic)
    }
    
    
    func createTableView() {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableViewController.tableView = tableView
        tableViewController.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentefier)
        tableViewController.tableView.delegate = self
        tableViewController.tableView.dataSource = self
        
        view.addSubview(tableViewController.tableView)

        // Установка ограничений
        NSLayoutConstraint.activate([
            tableViewController.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableViewController.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableViewController.tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableViewController.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentefier, for: indexPath)
        let date = allTime[indexPath.row]
        cell.textLabel?.text = "\(date)"
        return cell
    }
}

