//
//  UserDefaults + Extension.swift
//  AppleMusicApp
//
//  Created by Alex Kulish on 11.10.2022.
//

import Foundation

extension UserDefaults {
    
    static let favouriteTrackKey = "favouriteTrackKey"
    
    func getSavedTracks() -> [SearchViewModel.Cell] {
        guard let savedData = self.object(forKey: UserDefaults.favouriteTrackKey) as? Data else { return [] }
        guard let savedTracks = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedData) as? [SearchViewModel.Cell] else { return [] }
        return savedTracks
    }
    
    func saveTracks(saveTracks: [SearchViewModel.Cell]) {
        guard let savedData = try? NSKeyedArchiver.archivedData(withRootObject: saveTracks, requiringSecureCoding: false) else { return }
        self.set(savedData, forKey: UserDefaults.favouriteTrackKey)
    }
}
