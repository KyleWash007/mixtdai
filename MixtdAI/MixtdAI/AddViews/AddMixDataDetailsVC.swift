import UIKit
import SKPhotoBrowser

class AddMixDataDetailsVC: UIViewController {
    @IBOutlet weak var contentView: UIView!
    var mix: MixAIResponse!
    var image: URL?
    var imageData: Data?
    var imageViewShow: UIImage?

    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()
    private var suggestedNameLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupContent()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func shareAction(_ sender: Any) {
        self.shareAsPDF()
    }

    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        contentStackView.axis = .vertical
        contentStackView.spacing = 16
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -16),
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
        ])
    }

    private func setupContent() {
        let imageContainer = UIView()
        imageContainer.translatesAutoresizingMaskIntoConstraints = false

        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 80
        imageView.layer.masksToBounds = true

        imageContainer.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 160),
            imageView.heightAnchor.constraint(equalToConstant: 160),
            imageView.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: imageContainer.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor)
        ])
        contentStackView.addArrangedSubview(imageContainer)

        if let imageURL = image {
            URLSession.shared.dataTask(with: imageURL) { data, _, error in
                guard let data = data, let uiImage = UIImage(data: data), error == nil else { return }
                DispatchQueue.main.async {
                    self.imageData = data
                    imageView.image = uiImage
                    self.imageViewShow = uiImage
                    self.addTabGesture(uiimage: imageView)
                }
            }.resume()
        } else {
            DispatchQueue.main.async {
                imageView.image = self.imageViewShow
                self.addTabGesture(uiimage: imageView)
            }
        }

        // Title + edit icon for Suggested Name
        let titleRow = UIStackView()
        titleRow.axis = .horizontal
        titleRow.alignment = .center
        titleRow.spacing = 8

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
        contentStackView.addArrangedSubview(titleRow)

        let nameLabel = UILabel()
        nameLabel.text = mix.suggestedName
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.textColor = .white
        nameLabel.numberOfLines = 0
        suggestedNameLabel = nameLabel

        contentStackView.addArrangedSubview(nameLabel)

        let items: [(String, String)] = [
            ("✨ What You Will Experience", mix.experience),
            ("🧪 Recommended Ratio", mix.recommendedRatio),
            ("🧬 What's the Science", mix.science),
            ("🎯 What Is This Mix Similar To?", mix.similarTo),
            ("💡 One Suggestion to Improve Your Mix", mix.improvementTip)
        ]

        for (title, value) in items {
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
            titleLabel.numberOfLines = 0
            titleLabel.textColor = .white

            let bodyLabel = UILabel()
            bodyLabel.text = value
            bodyLabel.font = UIFont.systemFont(ofSize: 16)
            bodyLabel.numberOfLines = 0
            bodyLabel.textColor = .white

            contentStackView.addArrangedSubview(titleLabel)
            contentStackView.addArrangedSubview(bodyLabel)
        }
    }

    @objc func editSuggestedName() {
        let alert = UIAlertController(title: "Edit Suggested Name", message: "Enter a new name for your mix", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.text = self.suggestedNameLabel?.text
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { _ in
            if let newName = alert.textFields?.first?.text, !newName.isEmpty {
                self.suggestedNameLabel?.text = newName
            }
        }))
        present(alert, animated: true, completion: nil)
    }

    func addTabGesture(uiimage: UIImageView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showImage))
        uiimage.addGestureRecognizer(tapGesture)
        uiimage.isUserInteractionEnabled = true
    }

    @objc func showImage() {
        if let ss = self.imageViewShow {
            let photo = SKPhoto.photoWithImage(ss)
            let browser = SKPhotoBrowser(photos: [photo])
            browser.initializePageIndex(0)
            present(browser, animated: true, completion: {})
        }
    }
}
extension AddMixDataDetailsVC {
    func shareAsPDF() {
        if let pdfURL = self.scrollView.exportContentAsPDFSS() {
            let avc = UIActivityViewController(
                activityItems: [pdfURL],
                applicationActivities: nil)
            avc.popoverPresentationController?.sourceView = view
            present(avc, animated: true)
        }
    }
    
}
