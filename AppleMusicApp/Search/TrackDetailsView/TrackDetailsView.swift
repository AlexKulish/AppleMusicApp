//
//  TrackDetailsView.swift
//  AppleMusicApp
//
//  Created by Alex Kulish on 13.09.2022.
//

import UIKit
import SDWebImage
import AVKit

class TrackDetailsView: UIView {
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var currentTimeSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    
    private lazy var player: AVPlayer = {
        let player = AVPlayer()
        player.automaticallyWaitsToMinimizeStalling = false
        return player
    }()
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func handleCurrentTimeSlider(_ sender: Any) {
    }
    
    @IBAction func handleVolumeSlider(_ sender: Any) {
    }
    
    @IBAction func hideScreenButtonPressed(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    @IBAction func previousTrackButtonPressed(_ sender: Any) {
    }
    
    @IBAction func nextTrackButtonPressed(_ sender: Any) {
    }
    
    @IBAction func playPauseButtonPressed(_ sender: Any) {
        
        if player.timeControlStatus == .paused {
            player.play()
            playPauseButton.setImage(UIImage(named: "Pause"), for: .normal)
        } else {
            player.pause()
            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
        }
        
    }
    
    func setupFrame(with someView: UIView) {
        self.frame = someView.frame
    }
    
    func configure(viewModel: SearchViewModel.Cell) {
        trackNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        playTrack(with: viewModel.previewUrl)
        let urlString600 = viewModel.iconStringUrl?.replacingOccurrences(of: "100x100", with: "600x600") ?? ""
        guard let url = URL(string: urlString600) else { return }
        trackImageView.sd_setImage(with: url, completed: nil)
    }
    
    private func playTrack(with previewURL: String?) {
        guard let url = URL(string: previewURL ?? "") else { return }
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
}
