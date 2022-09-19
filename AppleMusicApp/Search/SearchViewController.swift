//
//  SearchViewController.swift
//  AppleMusicApp
//
//  Created by Alex Kulish on 06.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchDisplayLogic: AnyObject {
    func displayData(viewModel: Search.Model.ViewModel.ViewModelData)
}

class SearchViewController: UIViewController, SearchDisplayLogic {
    
    @IBOutlet weak var tableView: UITableView!
    
    var interactor: SearchBusinessLogic?
    var router: (NSObjectProtocol & SearchRoutingLogic)?
    
    private var searchViewModel = SearchViewModel(cells: [])
    private var timer: Timer?
    private lazy var footerView = FooterView()
    
    
    // MARK: Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = SearchInteractor()
        let presenter             = SearchPresenter()
        let router                = SearchRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: Routing
    
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupSearchBar()
        setupTableView()
    }
    
    func displayData(viewModel: Search.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayTracks(let searchViewModel):
            print("viewController .displayTracks")
            self.searchViewModel = searchViewModel
            tableView.reloadData()
            footerView.hideLoader()
        case .displayFooterView:
            print("viewController .displayFooterView")
            footerView.showLoader()
        }
    }
    
    private func setupSearchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    private func setupTableView() {
        let nib = UINib(nibName: "TrackCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: TrackCell.reuseID)
        tableView.tableFooterView = footerView
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrackCell.reuseID, for: indexPath) as? TrackCell else { return UITableViewCell() }
        let searchViewModel = searchViewModel.cells[indexPath.row]
        cell.configure(viewModel: searchViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        84
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchViewModel = searchViewModel.cells[indexPath.row]
        print("searchViewModel.trackName: ", searchViewModel.trackName)
        
        let trackDetailsView: TrackDetailsView = TrackDetailsView.loadFromNib()
        trackDetailsView.setupFrame(with: view)
        trackDetailsView.configure(viewModel: searchViewModel)
        trackDetailsView.delegate = self
        let window = UIApplication.shared.keyWindow
        /*
         настройка без keyWindow
         let window = UIApplication.shared.connectedScenes
         .filter({$0.activationState == .foregroundActive})
         .compactMap({$0 as? UIWindowScene})
         .first?.windows
         .filter({$0.isKeyWindow}).first
         */
        window?.addSubview(trackDetailsView)
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Please, enter some search term"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        searchViewModel.cells.count > 0 ? 0 : 250
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.interactor?.makeRequest(request: .getTracks(searchText: searchText))
        })
    }
    
}

// MARK: - TrackMovingDelegate

extension SearchViewController: TrackMovingDelegate {
    
    private func getTrack(isNextTrack: Bool) -> SearchViewModel.Cell? {
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return nil }
        tableView.deselectRow(at: indexPath, animated: true)
        var newIndexPath: IndexPath?
        
        if isNextTrack {
            newIndexPath = IndexPath(row: indexPath.row + 1, section: indexPath.section)
            if newIndexPath?.row == searchViewModel.cells.count {
                newIndexPath?.row = 0
            }
        } else {
            newIndexPath = IndexPath(row: indexPath.row - 1, section: indexPath.section)
            if newIndexPath?.row == -1 {
                newIndexPath?.row = searchViewModel.cells.count - 1
            }
        }
        
        tableView.selectRow(at: newIndexPath, animated: true, scrollPosition: .none)
        let cellViewModel = searchViewModel.cells[newIndexPath?.row ?? 0]
        return cellViewModel
    }
    
    func playPreviousTrack() -> SearchViewModel.Cell? {
        getTrack(isNextTrack: false)
    }
    
    func playNextTrack() -> SearchViewModel.Cell? {
        getTrack(isNextTrack: true)
    }
    
    
}
