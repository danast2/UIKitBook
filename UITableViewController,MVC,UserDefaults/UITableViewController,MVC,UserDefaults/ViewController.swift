import UIKit

class ViewController: UIViewController {
    let tableView = UITableView()
    var allItem = ["Robbins", "Jobs", "Gilbert"]
    var cellIdentifier = "Cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        createTableView()
    }
    
    func createTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds // Добавление таблицы в представление
        view.addSubview(tableView)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let item = allItem[indexPath.row]
        cell.textLabel?.text = item
        return cell
    }
}

