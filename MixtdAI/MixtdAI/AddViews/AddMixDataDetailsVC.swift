//
//  AddMixDataDetailsVC.swift
//  MixtdAI
//
//  Created by Aravind Kumar on 27/07/25.
//

import UIKit
import SKPhotoBrowser

class AddMixDataDetailsVC: UIViewController {
    @IBOutlet weak var contentView: UIView!
    var mix: MixAIResponse!
    var image:URL?
    var imageData:Data?
    var imageViewShow:UIImage?
    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupContent()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
        // 1. If there's an image URL, show the image
            let imageContainer = UIView()
            imageContainer.translatesAutoresizingMaskIntoConstraints = false

            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 75
            imageView.layer.masksToBounds = true

            imageContainer.addSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(equalToConstant: 150),
                imageView.heightAnchor.constraint(equalToConstant: 150),
                imageView.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
                imageView.topAnchor.constraint(equalTo: imageContainer.topAnchor),
                imageView.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor)
            ])

            contentStackView.addArrangedSubview(imageContainer)

            // Load image async
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
            }else {
                DispatchQueue.main.async {
                    imageView.image = self.imageViewShow
                    self.addTabGesture(uiimage: imageView)
                    imageView.contentMode = .scaleAspectFill
                    imageView.layoutIfNeeded()

                    // Delay cornerRadius logic by 1 second
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        imageView.layer.cornerRadius = 75
                        imageView.layer.masksToBounds = true
                        imageView.clipsToBounds = true
                    }
                }
            }

        // 2. Add text content
        let items: [(String, String)] = [
            ("What You Will Experience", mix.experience),
            ("What's the Science 🧬", mix.science),
            ("What Is This Mix Similar To?", mix.similarTo),
            ("AI Image Prompt", mix.generatedImagePrompt),
            ("Suggested Name", mix.suggestedName),
            ("One Suggestion to Improve Your Mix", mix.improvementTip)
        ]

        for (title, value) in items {
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
            titleLabel.numberOfLines = 0

            let bodyLabel = UILabel()
            bodyLabel.text = value
            bodyLabel.font = UIFont.systemFont(ofSize: 16)
            bodyLabel.numberOfLines = 0

            contentStackView.addArrangedSubview(titleLabel)
            contentStackView.addArrangedSubview(bodyLabel)
        }
    }
    func addTabGesture(uiimage: UIImageView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showImage))
        uiimage.addGestureRecognizer(tapGesture)
        uiimage.isUserInteractionEnabled = true
    }
    // 1. create SKPhoto Array from UIImage
    @objc func showImage() {
        if let ss = self.imageViewShow {
            var images = [SKPhoto]()
            let photo = SKPhoto.photoWithImage(ss)// add some UIImage
            images.append(photo)
            
            // 2. create PhotoBrowser Instance, and present from your viewController.
            let browser = SKPhotoBrowser(photos: images)
            browser.initializePageIndex(0)
            present(browser, animated: true, completion: {})
        }
    }
}
