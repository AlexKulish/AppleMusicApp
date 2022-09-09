//
//  TrackModel.swift
//  AppleMusicApp
//
//  Created by Alex Kulish on 02.09.2022.
//

import Foundation

struct TrackModel: Decodable {
    let resultCount: Int
    let results: [Track]
}

struct Track: Decodable {
    let artistName: String
    let collectionName: String?
    let trackName: String?
    let artworkUrl100: String?
    let previewUrl: String?
}
