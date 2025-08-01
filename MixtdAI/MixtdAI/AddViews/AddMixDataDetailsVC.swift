import UIKit
import SKPhotoBrowser

class AddMixDataDetailsVC: UIViewController {
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var contentView: UIView!
    var mix: MixAIResponse!
    var image: URL?
    var imageData: Data?
    var imageViewShow: UIImage?
    var mixDetailsCell:MixDetailsCell?
    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.btnNext.applyGradient(colors: [
              UIColor.purple,UIColor.blue
          ])
    }

    @IBAction func postAction(_ sender: Any) {
        self.saveAndPostMix()
    }
    
    @IBAction func backAction(_ sender: Any) {
        let alert = UIAlertController(
            title: "Save and Post",
            message: "Do you want to save and post this mix?\n\nIf you cancel, you will lose your content.",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))

        alert.addAction(UIAlertAction(title: "Save & Post", style: .default, handler: { _ in
            self.saveAndPostMix()
            self.navigationController?.popViewController(animated: true)
        }))

        present(alert, animated: true, completion: nil)
    }

    @IBAction func shareAction(_ sender: Any) {
        self.shareAsPDF()
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MixDetailsCell.self, forCellReuseIdentifier: "MixDetailsCell")
        tableView.estimatedRowHeight = 600
        tableView.rowHeight = UITableView.automaticDimension

        contentView.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }

    func shareAsPDF() {
        if let pdfURL = self.mixDetailsCell?.exportAsPDF() {
            let avc = UIActivityViewController(
                activityItems: [pdfURL],
                applicationActivities: nil)
            avc.popoverPresentationController?.sourceView = view
            present(avc, animated: true)
        }
    }
}

extension AddMixDataDetailsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 1 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MixDetailsCell", for: indexPath) as? MixDetailsCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: mix, imageURL: image, fallbackImage: imageViewShow) { [weak self] updatedName in
            self?.mix.suggestedName = updatedName
        }
        self.mixDetailsCell = cell
        return cell
    }
}
extension AddMixDataDetailsVC {
    func saveAndPostMix() {
        self.showAlert(message: "Under Development")

    }
}
