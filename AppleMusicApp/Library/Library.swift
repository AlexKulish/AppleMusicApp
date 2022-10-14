//
//  Library.swift
//  AppleMusicApp
//
//  Created by Alex Kulish on 08.10.2022.
//

import SwiftUI

struct Library: View {
    
    // MARK: - Public properties
    
    weak var tabBarDelegate: MainTabBarControllerDelegate?
    
    // MARK: - Private properties
    
    @State private var tracks = UserDefaults.standard.getSavedTracks()
    @State private var isShowAlert = false
    @State private var track: SearchViewModel.Cell?
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                HStack(spacing: 20) {
                    Button {
                        self.track = tracks.first
                        tabBarDelegate?.maximizeTrackDetailsView(viewModel: self.track)
                        moveTrack()
                    } label: {
                        Image(systemName: "play.fill")
                            .frame(width: geometry.size.width / 2 - 10, height: 50)
                            .accentColor(.init(#colorLiteral(red: 1, green: 0.2823529412, blue: 0.4078431373, alpha: 1)))
                            .background(Color.init(.systemGray6))
                            .cornerRadius(10)
                    }
                    Button {
                        self.tracks = UserDefaults.standard.getSavedTracks()
                    } label: {
                        Image(systemName: "arrow.2.circlepath")
                            .frame(width: geometry.size.width / 2 - 10, height: 50)
                            .accentColor(.init(#colorLiteral(red: 1, green: 0.2823529412, blue: 0.4078431373, alpha: 1)))
                            .background(Color.init(.systemGray6))
                            .cornerRadius(10)
                    }
                }
                
            }
            .padding()
            .frame(height: 50)
            
            Divider()
                .padding()
            
            List {
                ForEach(tracks) { track in
                    LibraryCell(cell: track)
                        .frame(height: 84)
                        .gesture(LongPressGesture()
                                    .onEnded { _ in
                            self.track = track
                            self.isShowAlert = true
                        })
                        .simultaneousGesture(TapGesture()
                                    .onEnded { _ in
                            self.track = track
                            moveTrack()
                            tabBarDelegate?.maximizeTrackDetailsView(viewModel: self.track)
                        })
                }
                .onDelete(perform: deleteTrack)
            }
        }
        .actionSheet(isPresented: $isShowAlert) {
            ActionSheet(title: Text("Delete track?"),
                        buttons: [
                            .destructive(Text("Delete"), action: {
                deleteTrack(track: self.track)
            }) ,
                            .cancel()])
        }
    }
    
    // MARK: - Private methods
    
    private func deleteTrack(at offset: IndexSet) {
        tracks.remove(atOffsets: offset)
        UserDefaults.standard.saveTracks(saveTracks: tracks)
    }
    
    private func deleteTrack(track: SearchViewModel.Cell?) {
        guard let track = track else { return }
        guard let index = tracks.firstIndex(of: track) else { return }
        tracks.remove(at: index)
        UserDefaults.standard.saveTracks(saveTracks: tracks)
    }
}

// MARK: - Preview

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}

// MARK: - TrackMovingDelegate

extension Library: TrackMovingDelegate {
    
    func playPreviousTrack() -> SearchViewModel.Cell? {
        
        guard let track = track else { return nil }
        guard let index = tracks.firstIndex(of: track) else { return nil }
        
        var nextTrack: SearchViewModel.Cell?
        
        if index == 0 {
            nextTrack = tracks.last
        } else {
            nextTrack = tracks[index - 1]
        }
        
        self.track = nextTrack
        return nextTrack
        
    }
    
    func playNextTrack() -> SearchViewModel.Cell? {
        
        guard let track = track else { return nil }
        guard let index = tracks.firstIndex(of: track) else { return nil }
        
        var nextTrack: SearchViewModel.Cell?
        
        if index + 1 == tracks.count {
            nextTrack = tracks.first
        } else {
            nextTrack = tracks[index + 1]
        }
        
        self.track = nextTrack
        return nextTrack
        
    }
    
    private func moveTrack() {
        let keyWindow = UIApplication.shared.connectedScenes
            .filter({$0.activationState == .foregroundActive})
            .compactMap({$0 as? UIWindowScene})
            .first?.windows
            .filter({$0.isKeyWindow}).first
        let tabBarVC = keyWindow?.rootViewController as? MainTabBarController
        tabBarVC?.trackDetailsView.trackMovingDelegate = self
    }
    
}
