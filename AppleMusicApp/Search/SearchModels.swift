//
//  SearchModels.swift
//  AppleMusicApp
//
//  Created by Alex Kulish on 06.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

// MARK: - enum Search

enum Search {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getTracks(searchText: String)
            }
        }
        struct Response {
            enum ResponseType {
                case presentTracks(trackModel: TrackModel?)
                case presentFooterView
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayTracks(searchViewModel: SearchViewModel)
                case displayFooterView
            }
        }
    }
}

// MARK: - SearchViewModel

class SearchViewModel: NSObject, NSCoding {
    
    let cells: [Cell]
    
    init(cells: [Cell]) {
        self.cells = cells
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(cells, forKey: "cells")
    }
    
    required init?(coder: NSCoder) {
        cells = coder.decodeObject(forKey: "cells") as? [SearchViewModel.Cell] ?? []
    }
    
    // MARK: - Cell
    
    @objc(_TtCC13AppleMusicApp15SearchViewModel4Cell)class Cell: NSObject, NSCoding, Identifiable {
        
        let id = UUID()
        let artistName: String
        let collectionName: String
        let trackName: String
        let iconStringUrl: String?
        let previewUrl: String?
        
        init(artistName: String, collectionName: String, trackName: String, iconStringUrl: String?, previewUrl: String?) {
            self.artistName = artistName
            self.collectionName = collectionName
            self.trackName = trackName
            self.iconStringUrl = iconStringUrl
            self.previewUrl = previewUrl
        }
        
        func encode(with coder: NSCoder) {
            coder.encode(artistName, forKey: "artistName")
            coder.encode(collectionName, forKey: "collectionName")
            coder.encode(trackName, forKey: "trackName")
            coder.encode(iconStringUrl, forKey: "iconStringUrl")
            coder.encode(previewUrl, forKey: "previewUrl")
        }
        
        required init?(coder: NSCoder) {
            artistName = coder.decodeObject(forKey: "artistName") as? String ?? ""
            collectionName = coder.decodeObject(forKey: "collectionName") as? String ?? ""
            trackName = coder.decodeObject(forKey: "trackName") as? String ?? ""
            iconStringUrl = coder.decodeObject(forKey: "iconStringUrl") as? String? ?? ""
            previewUrl = coder.decodeObject(forKey: "previewUrl") as? String? ?? ""
        }
    }
}
