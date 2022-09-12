//
//  SearchModels.swift
//  AppleMusicApp
//
//  Created by Alex Kulish on 06.09.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

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

struct SearchViewModel {
    let cells: [Cell]
    
    struct Cell: TrackCellViewModelProtocol {
        let artistName: String
        let collectionName: String
        let trackName: String
        let iconStringUrl: String?
        let previewUrl: String?
    }
}
