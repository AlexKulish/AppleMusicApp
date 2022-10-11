//
//  TrackCell.swift
//  AppleMusicApp
//
//  Created by Alex Kulish on 09.09.2022.
//

import UIKit
import SDWebImage

//protocol TrackCellViewModelProtocol {
//    var trackName: String { get }
//    var artistName: String { get }
//    var collectionName: String { get }
//    var iconStringUrl: String? { get }
//}

class TrackCell: UITableViewCell {
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var addTrackButton: UIButton!
    
    static let reuseID = "TrackCell"
    private var cell: SearchViewModel.Cell?
    private let userDefaults = UserDefaults.standard
    private var tracksList = [SearchViewModel.Cell]()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackImageView.image = nil
    }
    
    @IBAction func addTrackAction(_ sender: Any) {
        addTrackButton.isHidden = true
        
        tracksList = userDefaults.getSavedTracks()
        
        guard let cell = cell else { return }
        tracksList.append(cell)
        
        userDefaults.saveTracks(saveTracks: tracksList)
    }
    
    func configure(viewModel: SearchViewModel.Cell) {
        cell = viewModel
        
        isFavouriteTrack()
        
        trackNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName
        
        guard let url = URL(string: viewModel.iconStringUrl ?? "") else { return }
        trackImageView.sd_setImage(with: url)
    }
    
    private func isFavouriteTrack() {
        let savedTracks = userDefaults.getSavedTracks()
        
        let isFavourite = savedTracks.firstIndex { track in
            track.trackName == cell?.trackName && track.artistName == cell?.artistName
        } != nil
        
        if isFavourite {
            addTrackButton.isHidden = true
        } else {
            addTrackButton.isHidden = false
        }
    }
    
}
