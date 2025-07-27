//
//  AddMixDataDetailsVC.swift
//  MixtdAI
//
//  Created by Aravind Kumar on 27/07/25.
//

import UIKit

class AddMixDataDetailsVC: UIViewController {
    @IBOutlet weak var contentView: UIView!
    var mix: MixAIResponse!

    private let scrollView = UIScrollView()
    private let contentStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupContent()
        // Do any additional setup after loading the view.
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

    
}
