//
//  SearchPresenter.swift
//  AppleMusicApp
//
//  Created by Alex Kulish on 06.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - SearchPresentationLogic

protocol SearchPresentationLogic {
    func presentData(response: Search.Model.Response.ResponseType)
}

class SearchPresenter: SearchPresentationLogic {
    
    // MARK: - Public properties
    
    weak var viewController: SearchDisplayLogic?
    
    // MARK: - Public methods
    
    func presentData(response: Search.Model.Response.ResponseType) {
        switch response {
        case .presentTracks(let trackModel):
            print("presenter .presentTracks")
            let cells = trackModel?.results.map { track in
                setupCellViewModel(from: track)
            } ?? []
            let searchViewModel = SearchViewModel(cells: cells)
            viewController?.displayData(viewModel: .displayTracks(searchViewModel: searchViewModel))
        case .presentFooterView:
            print("presenter .presentFooterView")
            viewController?.displayData(viewModel: .displayFooterView)
        }
    }
    
    // MARK: - Private methods
    
    private func setupCellViewModel(from track: Track) -> SearchViewModel.Cell {
        return SearchViewModel.Cell(artistName: track.artistName,
                                    collectionName: track.collectionName ?? "Unknown album",
                                    trackName: track.trackName ?? "Unknown track name",
                                    iconStringUrl: track.artworkUrl100,
                                    previewUrl: track.previewUrl)
        
    }
    
}
