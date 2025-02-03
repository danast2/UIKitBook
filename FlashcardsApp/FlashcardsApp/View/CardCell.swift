import UIKit

class CardCell: UITableViewCell {
    static let identifier = "CardCell"

    private let frontLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let backLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(containerView)
        containerView.addSubview(frontLabel)
        containerView.addSubview(backLabel)
        containerView.addSubview(dateLabel)
        containerView.addSubview(cardImageView)

        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            // Дата (правый верхний угол)
            dateLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),

            // Заголовок
            frontLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            frontLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            frontLabel.trailingAnchor.constraint(lessThanOrEqualTo: dateLabel.leadingAnchor, constant: -8),

            // Изображение (если есть)
            cardImageView.topAnchor.constraint(equalTo: frontLabel.bottomAnchor, constant: 8),
            cardImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            cardImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            cardImageView.heightAnchor.constraint(equalToConstant: 100),

            // Описание
            backLabel.topAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: 8),
            backLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            backLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            backLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with card: Card) {
        frontLabel.text = card.frontText
        backLabel.text = card.backText
        dateLabel.text = formatDate(card.createdAt)
        
        if let imageData = card.imageData, let image = UIImage(data: imageData) {
            cardImageView.image = image
            cardImageView.isHidden = false
        } else {
            cardImageView.isHidden = true
        }
    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter.string(from: date)
    }
}

