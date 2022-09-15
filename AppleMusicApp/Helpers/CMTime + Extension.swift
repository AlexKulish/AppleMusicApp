//
//  CMTime + Extension.swift
//  AppleMusicApp
//
//  Created by Alex Kulish on 15.09.2022.
//

import AVKit

extension CMTime {
    
    func displayString() -> String {
        guard !CMTimeGetSeconds(self).isNaN else { return "" }
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        let timeFormatString = String(format: "%02d:%02d", minutes, seconds)
        return timeFormatString
    }
    
}
