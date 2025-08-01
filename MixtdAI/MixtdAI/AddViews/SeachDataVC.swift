//
//  SeachDataVC.swift
//  MixtdAI
//
//  Created by Aravind Kumar on 01/08/25.
//

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

    var beerResults: [[String:Any]] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchUI()
    }

    private func setupSearchUI() {
        // Add Search Bar
        searchBar.delegate = self
        searchBar.placeholder = "Search Brewery"
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(searchBar)

        // Add Table View
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        contentView.addSubview(tableView)

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BeerCell")

        // Layout
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

    // MARK: - Search Bar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let query = searchBar.text, !query.isEmpty else { return }
        fetchBeers(for: query)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let beer = beerResults[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeerCell", for: indexPath)
        cell.textLabel?.text = beer["name"] as? String ?? "Unknown Beer"
        cell.detailTextLabel?.text = beer["brewery"] as? String ?? ""
        return cell
    }
    
    func fetchBeers(for brewery: String) {
        let headers = [
            "x-rapidapi-host": "beer9.p.rapidapi.com",
            "x-rapidapi-key": "b0665838dcmshf4226f990b06eb8p115074jsn547e69b46639"
        ]

        var components = URLComponents(string: "https://beer9.p.rapidapi.com/")!
        components.queryItems = [
            URLQueryItem(name: "brewery", value: brewery)
        ]

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
                    // Convert data to [[String: Any]]
                    if let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any], let jsonArray =  dict["data"] as? [[String:Any]]{
                        self.beerResults = jsonArray
                        print("✅ Parsed Beer Results: \(jsonArray)")
                        self.tableView.reloadData()
                    } else {
                        print("❌ JSON is not an array of dictionaries")
                    }
                } catch {
                    print("❌ JSON parsing error: \(error.localizedDescription)")
                    if let raw = String(data: data, encoding: .utf8) {
                        print("⚠️ Raw response: \(raw)")
                    }
                }
            }
        }.resume()
    }


}
