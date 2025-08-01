import UIKit
import SKPhotoBrowser

class MixDetailsCell: UITableViewCell {

    private let stackView = UIStackView()
    private let mixImageView = UIImageView()
    private let leftIngredientLabel = UILabel()
    private let rightIngredientLabel = UILabel()
    private let nameLabel = UILabel()
    private var onNameUpdate: ((String) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        backgroundColor = .black
        selectionStyle = .none

        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])

        // Image + Ingredients Row
        let imageRow = UIStackView()
        imageRow.axis = .horizontal
        imageRow.alignment = .center
        imageRow.spacing = 16
        imageRow.distribution = .equalCentering

        leftIngredientLabel.textColor = .white
        leftIngredientLabel.font = .systemFont(ofSize: 14)
        leftIngredientLabel.numberOfLines = 0
        leftIngredientLabel.textAlignment = .right
        leftIngredientLabel.setContentHuggingPriority(.required, for: .horizontal)

        rightIngredientLabel.textColor = .white
        rightIngredientLabel.font = .systemFont(ofSize: 14)
        rightIngredientLabel.numberOfLines = 0
        rightIngredientLabel.textAlignment = .left
        rightIngredientLabel.setContentHuggingPriority(.required, for: .horizontal)

        mixImageView.translatesAutoresizingMaskIntoConstraints = false
        mixImageView.contentMode = .scaleAspectFill
        mixImageView.layer.cornerRadius = 80
        mixImageView.clipsToBounds = true
        mixImageView.backgroundColor = .lightGray
        mixImageView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        mixImageView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        mixImageView.isUserInteractionEnabled = true

        let tap = UITapGestureRecognizer(target: self, action: #selector(showImage))
        mixImageView.addGestureRecognizer(tap)

        imageRow.addArrangedSubview(leftIngredientLabel)
        imageRow.addArrangedSubview(mixImageView)
        imageRow.addArrangedSubview(rightIngredientLabel)
        stackView.addArrangedSubview(imageRow)

        // Suggested Name Row
        let titleRow = UIStackView()
        titleRow.axis = .horizontal
        titleRow.spacing = 8
        titleRow.alignment = .center

        let titleLabel = UILabel()
        titleLabel.text = "Suggested Name"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .white

        let editButton = UIButton(type: .system)
        editButton.setImage(UIImage(systemName: "pencil"), for: .normal)
        editButton.tintColor = .white
        editButton.addTarget(self, action: #selector(editSuggestedName), for: .touchUpInside)

        titleRow.addArrangedSubview(titleLabel)
        titleRow.addArrangedSubview(editButton)
        stackView.addArrangedSubview(titleRow)

        // Name Label
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 0
        nameLabel.font = .systemFont(ofSize: 16)
        stackView.addArrangedSubview(nameLabel)
    }

    func configure(with mix: MixAIResponse, imageURL: URL?, fallbackImage: UIImage?, onNameUpdate: @escaping (String) -> Void) {
        self.onNameUpdate = onNameUpdate
        nameLabel.text = mix.suggestedName

        leftIngredientLabel.text = mix.leftIngredient ?? ""
        rightIngredientLabel.text = mix.rightIngredient ?? ""

        let items: [(String, String)] = [
            ("✨ What You Will Experience", mix.experience),
            ("🧬 What's the Science", mix.science),
            ("🧪 Recommended Ratio", mix.recommendedRatio),
            ("🎯 What Is This Mix Similar To?", mix.similarTo),
            ("💡 One Suggestion to Improve Your Mix", mix.improvementTip)
        ]

        for (title, value) in items {
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
            titleLabel.textColor = .white
            titleLabel.numberOfLines = 0

            let bodyLabel = UILabel()
            bodyLabel.text = value
            bodyLabel.font = .systemFont(ofSize: 16)
            bodyLabel.textColor = .white
            bodyLabel.numberOfLines = 0

            stackView.addArrangedSubview(titleLabel)
            stackView.addArrangedSubview(bodyLabel)
        }

        if let url = imageURL {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.mixImageView.image = image
                    }
                }
            }.resume()
        } else if let fallback = fallbackImage {
            mixImageView.image = fallback
        }
    }

    @objc private func showImage() {
        guard let image = mixImageView.image else { return }
        let photo = SKPhoto.photoWithImage(image)
        let browser = SKPhotoBrowser(photos: [photo])
        browser.initializePageIndex(0)
        UIApplication.shared.windows.first?.rootViewController?.present(browser, animated: true)
    }

    @objc private func editSuggestedName() {
        guard let rootVC = UIApplication.shared.windows.first?.rootViewController else { return }
        let alert = UIAlertController(title: "Edit Suggested Name", message: "Enter a new name for your mix", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = self.nameLabel.text
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
            if let newName = alert.textFields?.first?.text, !newName.isEmpty {
                self.nameLabel.text = newName
                self.onNameUpdate?(newName)
            }
        }))
        rootVC.present(alert, animated: true)
    }
}
