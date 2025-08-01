import UIKit

struct Beer: Codable {
    let name: String?
    let brewery: String?
    let style: String?
    let abv: String?
    let ibu: String?
}

class SearchDataVC: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var contentView: UIView!

    private let searchBar = UISearchBar()
    private let tableView = UITableView()

    var beerResults: [[String: Any]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.backgroundColor = .clear
        setupSearchUI()
    }

    private func setupSearchUI() {
        // Search Bar Setup
        searchBar.delegate = self
        searchBar.placeholder = "Search Brewery"
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.backgroundColor = .darkGray
        searchBar.barStyle = .black
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(searchBar)

        // TableView Setup
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BeerTableViewCell.self, forCellReuseIdentifier: "BeerCell")
        tableView.backgroundColor = .black
        tableView.separatorStyle = .none
        contentView.addSubview(tableView)

        // Layout Constraints
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: contentView.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    // MARK: - TableView Delegates
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeerCell", for: indexPath) as? BeerTableViewCell else {
            return UITableViewCell()
        }

        let beer = beerResults[indexPath.row]
        cell.nameLabel.text = beer["name"] as? String ?? "Unknown Beer"
        cell.breweryLabel.text = beer["brewery"] as? String ?? "Unknown Brewery"
        return cell
    }

    // MARK: - Search Bar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let query = searchBar.text, !query.isEmpty else { return }
        fetchBeers(for: query)
    }

    // MARK: - API Call
    func fetchBeers(for brewery: String) {
        let headers = [
            "x-rapidapi-host": "beer9.p.rapidapi.com",
            "x-rapidapi-key": "b0665838dcmshf4226f990b06eb8p115074jsn547e69b46639"
        ]

        var components = URLComponents(string: "https://beer9.p.rapidapi.com/")!
        components.queryItems = [URLQueryItem(name: "brewery", value: brewery)]

        guard let url = components.url else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }

                guard let data = data else {
                    print("No data received")
                    return
                }

                do {
                    if let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let jsonArray = dict["data"] as? [[String: Any]] {
                        self.beerResults = jsonArray
                        self.tableView.reloadData()
                    } else {
                        print("❌ JSON format error")
                    }
                } catch {
                    print("JSON Error: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}
