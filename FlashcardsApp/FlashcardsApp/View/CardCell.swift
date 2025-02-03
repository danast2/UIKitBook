import UIKit

class CardCell: UITableViewCell {
    
    static let identifier = "CardCell"

    private let frontLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .label
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
    
    private let createdAtLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .gray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let updatedAtLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .gray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        containerView.addSubview(createdAtLabel)
        containerView.addSubview(updatedAtLabel)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            createdAtLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            createdAtLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),

            updatedAtLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            updatedAtLabel.topAnchor.constraint(equalTo: createdAtLabel.bottomAnchor, constant: 2),

            frontLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            frontLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            frontLabel.trailingAnchor.constraint(lessThanOrEqualTo: createdAtLabel.leadingAnchor, constant: -8),

            backLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            backLabel.topAnchor.constraint(equalTo: frontLabel.bottomAnchor, constant: 4),
            backLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with card: Card) {
        frontLabel.text = card.frontText
        backLabel.text = card.backText
        createdAtLabel.text = "📅 \(formatDate(card.createdAt))"
        updatedAtLabel.text = "🔄 \(formatDate(card.lastUpdated))"
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter.string(from: date)
    }
}

