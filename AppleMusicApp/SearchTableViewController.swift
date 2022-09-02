//
//  SearchTableViewController.swift
//  AppleMusicApp
//
//  Created by Alex Kulish on 31.08.2022.
//

import UIKit
import Alamofire

class SearchTableViewController: UITableViewController {
    
    private var timer: Timer?
    
    private var tracks = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        
        view.backgroundColor = .white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
}

// MARK: - TableViewDelegate TableViewDataSource

extension SearchTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        let track = tracks[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.image = UIImage(named: "Image")
        content.text = "\(track.artistName)\n\(track.trackName ?? "Unknown track name")"
        cell.contentConfiguration = content
        return cell
    }
    
}

// MARK: - UISearchBarDelegate

extension SearchTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            
            let url = "https://itunes.apple.com/search"
            let parameters = ["term": "\(searchText)", "limit": "15"]
            
            AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default).responseData { data in
                if let error = data.error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let data = data.data else { return }
                
                let decoder = JSONDecoder()
                
                do {
                    let tracks = try decoder.decode(TrackModel.self, from: data)
                    self.tracks = tracks.results
                    self.tableView.reloadData()
                } catch let error {
                    print("Failed to decode JSON", error)
                }
            }
        })
    }
    
}
