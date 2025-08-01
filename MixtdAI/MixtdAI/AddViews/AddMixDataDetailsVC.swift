import UIKit
import SKPhotoBrowser

class AddMixDataDetailsVC: UIViewController {
    var loaderAnimationView:LoaderAnimationView?

    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var contentView: UIView!
    var mix: MixAIResponse!
    var image: URL?
    var imageData: Data?
    var imageViewShow: UIImage?
    var mixDetailsCell:MixDetailsCell?
    private let tableView = UITableView()
    private let chatService = ChatGPTService()

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
            title: "Do you want to save and post this mix?",
            message: "If you cancel, you will lose your content.",
            preferredStyle: .alert
        )


        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: { _ in
            self.navigationController?.popViewController(animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Save & Post", style: .default, handler: { _ in
            self.saveAndPostMix()
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
        cell.delegate = self
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
extension AddMixDataDetailsVC: MixDetailsCellDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    func didSelectView(in cell: MixDetailsCell) {
        guard let image = cell.mixImageView.image else { return }
             let photo = SKPhoto.photoWithImage(image)
             let browser = SKPhotoBrowser(photos: [photo])
             browser.initializePageIndex(0)
             UIApplication.shared.windows.first?.rootViewController?.present(browser, animated: true)
         }
   
    func didSelectGenerateByAI(in cell: MixDetailsCell) {
        // Handle AI generation
        print("Generate by AI tapped")
        self.createAiImage()
    }
    func createAiImage() {
        if  self.loaderAnimationView ==  nil {
            self.loaderAnimationView = LoaderAnimationView(frame: view.bounds)
        }
        view.addSubview( self.loaderAnimationView!)
        self.loaderAnimationView?.startAnimation()
        
        self.chatService.generateImageURL(from: "Create a combined circular colorfull tansparant logo of \(self.mix.leftIngredient ?? "") and \(self.mix.rightIngredient ?? "")") { imageResult in
            switch imageResult {
            case .success(let imageURL):
                
                    URLSession.shared.dataTask(with: imageURL) { data, _, _ in
                        if let data = data, let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self.loaderAnimationView?.removeFromSuperview()

                                self.imageViewShow = image
                                self.imageData = image.pngData()
                                self.tableView.reloadData()
                                
                            }
                        }
                    }.resume()
                    
                
            case .failure(let error):
                print("Image generation failed: \(error)")
                DispatchQueue.main.async {
                    self.loaderAnimationView?.removeFromSuperview()
                }
            }
        }
    }
    func didSelectCamera(in cell: MixDetailsCell) {
        // Present UIImagePickerController for camera
        presentImagePicker(sourceType: .camera)
    }

    func didSelectGallery(in cell: MixDetailsCell) {
        // Present UIImagePickerController for photo library
        presentImagePicker(sourceType: .photoLibrary)
    }

    private func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return }
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = self
        present(picker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)

        if let image = info[.originalImage] as? UIImage {
            // 🔁 You now have the selected image here
            print("Selected image:", image)
            DispatchQueue.main.async {
                      self.imageViewShow = image
                      self.imageData = image.pngData()
                      self.tableView.reloadData()
                  }
            
        }
        else if let image = info[.editedImage] as? UIImage {
            // 🔁 You now have the selected image here
            print("Selected image:", image)

            DispatchQueue.main.async {
                      self.imageViewShow = image
                      self.imageData = image.pngData()
                      self.tableView.reloadData()
                  }

        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
