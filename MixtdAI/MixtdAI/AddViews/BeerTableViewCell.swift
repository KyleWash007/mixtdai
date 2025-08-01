import UIKit

class BeerTableViewCell: UITableViewCell {

    let nameLabel = UILabel()
    let breweryLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }

    private func setupViews() {
        backgroundColor = .black
        selectionStyle = .none

        // Name label setup
        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 2
        nameLabel.lineBreakMode = .byTruncatingTail
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        // Brewery label setup
        breweryLabel.font = UIFont.systemFont(ofSize: 12)
        breweryLabel.textColor = .lightGray
        breweryLabel.numberOfLines = 1
        breweryLabel.translatesAutoresizingMaskIntoConstraints = false

        // Add views
        contentView.addSubview(nameLabel)
        contentView.addSubview(breweryLabel)

        // Layout constraints
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            breweryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 6),
            breweryLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            breweryLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            breweryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
