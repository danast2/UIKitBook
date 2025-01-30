import UIKit

class ViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let items: [Menu] = [
        Menu(name: "Coca Cola", imageName: "drink"),
        Menu(name: "Pepsi", imageName: "cherry"),
//        Menu(name: "Sprite", imageName: "sprite"),
//        Menu(name: "Fanta", imageName: "fanta")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Меню напитков"
        collectionView.backgroundColor = .white
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: MenuCollectionViewCell.identifier)
    }

    // Количество элементов в секции
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    // Настройка ячейки
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MenuCollectionViewCell.identifier,
            for: indexPath
        ) as? MenuCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let menuItem = items[indexPath.item]
        cell.configure(with: menuItem)
        return cell
    }

    // Размер ячейки
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 30) / 2
        return CGSize(width: width, height: 150)
    }

    // Отступы между ячейками
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

