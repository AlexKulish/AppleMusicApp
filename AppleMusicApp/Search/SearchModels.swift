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
                case some
                case getTracks(searchText: String)
            }
        }
        struct Response {
            enum ResponseType {
                case some
                case presentTracks(trackModel: TrackModel?)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case some
                case displayTracks(searchViewModel: SearchViewModel)
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
