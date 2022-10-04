//
//  TrackDetailsView.swift
//  AppleMusicApp
//
//  Created by Alex Kulish on 13.09.2022.
//

import UIKit
import SDWebImage
import AVKit

protocol TrackMovingDelegate: AnyObject {
    func playPreviousTrack() -> SearchViewModel.Cell?
    func playNextTrack() -> SearchViewModel.Cell?
}

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
    
    @IBOutlet weak var miniTrackDetailsView: UIView!
    @IBOutlet weak var miniTrackImageView: UIImageView!
    @IBOutlet weak var miniTrackNameLabel: UILabel!
    @IBOutlet weak var miniGoForwardButton: UIButton!
    @IBOutlet weak var miniPlayPauseButton: UIButton!
    
    @IBOutlet weak var maximizedStackView: UIStackView!
    
    
    weak var delegate: TrackMovingDelegate?
    weak var tabBarDelegate: MainTabBarControllerDelegate?
    
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
        guard let duration = player.currentItem?.duration else { return }
        let percentage = currentTimeSlider.value
        let durationInSeconds = CMTimeGetSeconds(duration)
        let seekTimeInSeconds = Float64(percentage) * durationInSeconds
        let seekTime = CMTimeMakeWithSeconds(seekTimeInSeconds, preferredTimescale: 1)
        player.seek(to: seekTime)
    }
    
    @IBAction func handleVolumeSlider(_ sender: Any) {
        player.volume = volumeSlider.value
    }
    
    @IBAction func hideScreenButtonPressed(_ sender: Any) {
        tabBarDelegate?.minimizeTrackDetailsView()
    }
    
    @IBAction func previousTrackButtonPressed(_ sender: Any) {
        guard let cellViewModel = delegate?.playPreviousTrack() else { return }
        configure(viewModel: cellViewModel)
    }
    
    @IBAction func nextTrackButtonPressed(_ sender: Any) {
        guard let cellViewModel = delegate?.playNextTrack() else { return }
        configure(viewModel: cellViewModel)
    }
    
    @IBAction func playPauseButtonPressed(_ sender: Any) {
        
        if player.timeControlStatus == .paused {
            player.play()
            playPauseButton.setImage(UIImage(named: "Pause"), for: .normal)
            miniPlayPauseButton.setImage(UIImage(named: "Pause"), for: .normal)
            increaseTrackImageView()
        } else {
            player.pause()
            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
            miniPlayPauseButton.setImage(UIImage(named: "play"), for: .normal)
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
        miniTrackNameLabel.text = viewModel.trackName
        playTrack(with: viewModel.previewUrl)
        monitoringStartTime()
        observePlayerCurrentTime()
        let urlString600 = viewModel.iconStringUrl?.replacingOccurrences(of: "100x100", with: "600x600") ?? ""
        guard let url = URL(string: urlString600) else { return }
        trackImageView.sd_setImage(with: url, completed: nil)
        miniTrackImageView.sd_setImage(with: url, completed: nil)
        playPauseButton.setImage(UIImage(named: "Pause"), for: .normal)
        miniPlayPauseButton.setImage(UIImage(named: "Pause"), for: .normal)
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
    
    private func observePlayerCurrentTime() {
        
        let interval = CMTimeMake(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            self?.currentTimeLabel.text = time.displayString()
            
            let durationTime = self?.player.currentItem?.duration
            let durationTimeText = ((durationTime ?? CMTimeMake(value: 1, timescale: 1)) - time).displayString()
            self?.durationLabel.text = "-\(durationTimeText)"
            self?.updateCurrentTimeSlider()
        }
        
    }
    
    private func updateCurrentTimeSlider() {
        let currentTimeSeconds = CMTimeGetSeconds(player.currentTime())
        let durationTimeSeconds = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        let percentage = currentTimeSeconds / durationTimeSeconds
        currentTimeSlider.value = Float(percentage)
    }
    
    deinit {
        print("deinit class")
    }
    
}
