//
//  TrackDetailsView.swift
//  AppleMusicApp
//
//  Created by Alex Kulish on 13.09.2022.
//

import UIKit

class TrackDetailsView: UIView {
    
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var currentTimeSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!
    
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
    }
    
}
