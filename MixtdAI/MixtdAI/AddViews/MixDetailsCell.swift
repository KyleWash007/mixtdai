import UIKit
import SKPhotoBrowser
protocol MixDetailsCellDelegate: AnyObject {
    func didSelectGenerateByAI(in cell: MixDetailsCell)
    func didSelectCamera(in cell: MixDetailsCell)
    func didSelectGallery(in cell: MixDetailsCell)
    func didSelectView(in cell: MixDetailsCell)
}
class MixDetailsCell: UITableViewCell{
    weak var delegate: MixDetailsCellDelegate?
    var imageFound = false
    private let stackView = UIStackView()
    let mixImageView = UIImageView()
    private let photoOverlayIcon = UIImageView()
    private let leftIngredientLabel = UILabel()
    private let rightIngredientLabel = UILabel()
    private let nameLabel = UILabel()
    private var onNameUpdate: ((String) -> Void)?
    
    private weak var presentingViewController: UIViewController?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI()  {
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

        // MARK: - Image + Labels Container View
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(container)

        // Add mixImageView
        mixImageView.translatesAutoresizingMaskIntoConstraints = false
        mixImageView.contentMode = .scaleAspectFill
        mixImageView.layer.cornerRadius = 80
        mixImageView.clipsToBounds = true
        mixImageView.backgroundColor = .lightGray
        mixImageView.isUserInteractionEnabled = true
        container.addSubview(mixImageView)

        NSLayoutConstraint.activate([
            mixImageView.topAnchor.constraint(equalTo: container.topAnchor),
            mixImageView.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            mixImageView.widthAnchor.constraint(equalToConstant: 160),
            mixImageView.heightAnchor.constraint(equalToConstant: 160),
            mixImageView.bottomAnchor.constraint(lessThanOrEqualTo: container.bottomAnchor)
        ])

        let tap = UITapGestureRecognizer(target: self, action: #selector(showImageOptions))
        mixImageView.addGestureRecognizer(tap)

        // Overlay icon
        photoOverlayIcon.translatesAutoresizingMaskIntoConstraints = false
        photoOverlayIcon.image = UIImage(systemName: "plus.circle.fill")
        photoOverlayIcon.tintColor = .white
        mixImageView.addSubview(photoOverlayIcon)
        photoOverlayIcon.isHidden = true

        NSLayoutConstraint.activate([
            photoOverlayIcon.centerXAnchor.constraint(equalTo: mixImageView.centerXAnchor),
            photoOverlayIcon.centerYAnchor.constraint(equalTo: mixImageView.centerYAnchor),
            photoOverlayIcon.widthAnchor.constraint(equalToConstant: 30),
            photoOverlayIcon.heightAnchor.constraint(equalToConstant: 30)
        ])

        // Labels Stack (Left Side)
        let labelStack = UIStackView()
        labelStack.axis = .vertical
        labelStack.spacing = 8
        labelStack.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(labelStack)

        leftIngredientLabel.textColor = .white
        leftIngredientLabel.font = .systemFont(ofSize: 14)
        leftIngredientLabel.numberOfLines = 0
        leftIngredientLabel.textAlignment = .left

        rightIngredientLabel.textColor = .white
        rightIngredientLabel.font = .systemFont(ofSize: 14)
        rightIngredientLabel.numberOfLines = 0
        rightIngredientLabel.textAlignment = .left

        labelStack.addArrangedSubview(leftIngredientLabel)
        labelStack.addArrangedSubview(rightIngredientLabel)

        NSLayoutConstraint.activate([
            labelStack.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            labelStack.trailingAnchor.constraint(equalTo: mixImageView.leadingAnchor, constant: -16),
            labelStack.topAnchor.constraint(equalTo: mixImageView.topAnchor),
            labelStack.bottomAnchor.constraint(lessThanOrEqualTo: container.bottomAnchor)
        ])

        // MARK: - Suggested Name Row
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
                        self.imageFound = true
                    }
                }
            }.resume()
        } else if let fallback = fallbackImage {
            mixImageView.image = fallback
            self.imageFound = true
        }else {
            mixImageView.image = UIImage(named: "gnrate")
        }

        // capture presenting view controller
        presentingViewController = UIApplication.shared.windows.first?.rootViewController
    }

    @objc private func showImageOptions() {
        self.delegate?.didSelectGenerateByAI(in: self)

    }
//    {
//        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
//
//        alert.addAction(UIAlertAction(title: "Generate by AI", style: .default, handler: { _ in
//            self.delegate?.didSelectGenerateByAI(in: self)
//        }))
//        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
//            self.delegate?.didSelectCamera(in: self)
//        }))
//        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
//            self.delegate?.didSelectGallery(in: self)
//        }))
//        if self.imageFound {
//            alert.addAction(UIAlertAction(title: "View", style: .default, handler: { _ in
//                self.delegate?.didSelectView(in: self)
//            }))
//        }
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//
//        presentingViewController?.present(alert, animated: true)
//    }

   

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
