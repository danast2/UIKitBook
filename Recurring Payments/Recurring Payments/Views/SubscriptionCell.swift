import UIKit

class SubscriptionCell: UITableViewCell {
    
    static let identifier = "SubscriptionCell"

    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .systemGreen
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let renewalDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nextRenewalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(iconView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(renewalDateLabel)
        stackView.addArrangedSubview(nextRenewalLabel)

        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 40),
            iconView.heightAnchor.constraint(equalToConstant: 40),
            
            stackView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with subscription: Subscription) {
        nameLabel.text = subscription.name
        priceLabel.text = "\(subscription.price) ₽"
        renewalDateLabel.text = "Списание: \(subscription.renewalDate.formatted())"
        iconView.image = UIImage(systemName: "creditcard")
        
        //рассчитываем дату next списания
        let nextBillingDate = calculateNextBillingDate(for: subscription)
        nextRenewalLabel.text = "Следующее списание: \(nextBillingDate.formatted())"
    }
    
    //метод для рассчета даты списания
    private func calculateNextBillingDate(for subscription: Subscription) -> Date {
        let calendar = Calendar.current
        switch subscription.cycle {
        case .monthly:
            return calendar.date(byAdding: .month, value: 1, to: subscription.renewalDate) ?? subscription.renewalDate
        case .yearly:
            return calendar.date(byAdding: .year, value: 1, to: subscription.renewalDate) ?? subscription.renewalDate
        case .weekly:
            return calendar.date(byAdding: .day, value: 7, to: subscription.renewalDate) ?? subscription.renewalDate
        case .halfOfMonth:
            return calendar.date(byAdding: .day, value: 14, to: subscription.renewalDate) ?? subscription.renewalDate
        case .halfOfYear:
            return calendar.date(byAdding: .month, value: 6, to: subscription.renewalDate) ?? subscription.renewalDate
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        priceLabel.text = nil
        renewalDateLabel.text = nil
        nextRenewalLabel.text = nil
        iconView.image = nil
    }
}

