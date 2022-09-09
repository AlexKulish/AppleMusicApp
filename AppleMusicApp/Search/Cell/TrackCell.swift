//
//  TrackCell.swift
//  AppleMusicApp
//
//  Created by Alex Kulish on 09.09.2022.
//

import UIKit

protocol TrackCellViewModelProtocol {
    var trackName: String { get }
    var artistName: String { get }
    var collectionName: String { get }
    var iconStringUrl: String? { get }
}

class TrackCell: UITableViewCell {
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    
    static let reuseID = "TrackCell"
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(viewModel: TrackCellViewModelProtocol) {
        trackNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName
    }
    
}
