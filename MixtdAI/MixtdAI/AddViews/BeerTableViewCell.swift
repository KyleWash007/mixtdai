import UIKit

class BeerTableViewCell: UITableViewCell {

    let nameLabel = UILabel()
    let breweryLabel = UILabel()
    private let arrowImageView = UIImageView()

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

        nameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        nameLabel.textColor = .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        breweryLabel.font = UIFont.systemFont(ofSize: 12)
        breweryLabel.textColor = .white
        breweryLabel.translatesAutoresizingMaskIntoConstraints = false

        arrowImageView.image = UIImage(systemName: "chevron.right")
        arrowImageView.tintColor = .white
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(nameLabel)
        contentView.addSubview(breweryLabel)
        contentView.addSubview(arrowImageView)

        NSLayoutConstraint.activate([
            arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            arrowImageView.widthAnchor.constraint(equalToConstant: 12),
            arrowImageView.heightAnchor.constraint(equalToConstant: 16),

            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -8),

            breweryLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            breweryLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            breweryLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            breweryLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
}
