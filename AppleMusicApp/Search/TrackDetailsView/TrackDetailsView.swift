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
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var currentTimeSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    
    // MARK: - Private properties
    
    private lazy var player: AVPlayer = {
        let player = AVPlayer()
        player.automaticallyWaitsToMinimizeStalling = false
        return player
    }()
    
    // MARK: - awakeFromNib
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let scale: CGFloat = 0.8
        trackImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        trackImageView.layer.cornerRadius = 10
    }
    
    // MARK: - IBActions
    
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
            increaseTrackImageView()
        } else {
            player.pause()
            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
            decreaseTrackImageView()
        }
        
    }
    
    // MARK: - Setup
    
    func setupFrame(with someView: UIView) {
        self.frame = someView.frame
    }
    
    func configure(viewModel: SearchViewModel.Cell) {
        trackNameLabel.text = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        playTrack(with: viewModel.previewUrl)
        monitoringStartTime()
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
    
    // MARK: - Animations
    
    private func increaseTrackImageView() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.trackImageView.transform = .identity
        }, completion: nil)
    }
    
    private func decreaseTrackImageView() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            let scale: CGFloat = 0.8
            self.trackImageView.transform = CGAffineTransform(scaleX: scale, y: scale)
        }, completion: nil)
    }
    
    // MARK: - Time observer
    
    private func monitoringStartTime() {
        let time = CMTimeMake(value: 1, timescale: 3)
        let times = [NSValue(time: time)]
        
        player.addBoundaryTimeObserver(forTimes: times, queue: .main) { [weak self] in
            self?.increaseTrackImageView()
        }
    }
    
    deinit {
        print("deinit class")
    }
    
}
