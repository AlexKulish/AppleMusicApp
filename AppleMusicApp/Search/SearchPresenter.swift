//
//  SearchPresenter.swift
//  AppleMusicApp
//
//  Created by Alex Kulish on 06.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol SearchPresentationLogic {
    func presentData(response: Search.Model.Response.ResponseType)
}

class SearchPresenter: SearchPresentationLogic {
    weak var viewController: SearchDisplayLogic?
    
    func presentData(response: Search.Model.Response.ResponseType) {
        switch response {
        case .some:
            print("presenter .some")
        case .presentTracks(let trackModel):
            print("presenter .presentTracks")
            let cells = trackModel?.results.map { track in
                setupCellViewModel(from: track)
            } ?? []
            let searchViewModel = SearchViewModel(cells: cells)
            viewController?.displayData(viewModel: .displayTracks(searchViewModel: searchViewModel))
        }
    }
    
    private func setupCellViewModel(from track: Track) -> SearchViewModel.Cell {
        return SearchViewModel.Cell(artistName: track.artistName,
                                    collectionName: track.collectionName ?? "Unknown album",
                                    trackName: track.trackName ?? "Unknown track name",
                                    iconStringUrl: track.artworkUrl100,
                                    previewUrl: track.previewUrl)
        
    }
    
}
