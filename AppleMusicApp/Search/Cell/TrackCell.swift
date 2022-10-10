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
    
    static let reuseID = "TrackCell"
    private var cell: SearchViewModel.Cell?
    private let userDefaults = UserDefaults.standard
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        trackImageView.image = nil
    }
    
    func configure(viewModel: SearchViewModel.Cell) {
        cell = viewModel
        trackNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        collectionNameLabel.text = viewModel.collectionName
        
        guard let url = URL(string: viewModel.iconStringUrl ?? "") else { return }
        trackImageView.sd_setImage(with: url)
    }
    
    @IBAction func addTrackAction(_ sender: Any) {
        if let savedTracks = try? NSKeyedArchiver.archivedData(withRootObject: cell, requiringSecureCoding: false) {
            print("Успешно!")
            userDefaults.set(savedTracks, forKey: "tracks")
        }
    }
    
    @IBAction func showTrack(_ sender: Any) {
        print("show track")
        if let savedData = userDefaults.object(forKey: "tracks") as? Data {
            if let savedTracks = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? SearchViewModel.Cell {
                print("savedTrack: \(savedTracks.trackName)")
            }
        }
    }
    
}
