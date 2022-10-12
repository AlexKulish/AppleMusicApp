//
//  Library.swift
//  AppleMusicApp
//
//  Created by Alex Kulish on 08.10.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct Library: View {
    
    @State private var tracks = UserDefaults.standard.getSavedTracks()
    @State private var isShowAlert = false
    @State private var track: SearchViewModel.Cell?
    
    weak var tabBarDelegate: MainTabBarControllerDelegate?
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                HStack(spacing: 20) {
                    Button {
                        self.tabBarDelegate?.maximizeTrackDetailsView(viewModel: tracks.first)
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
//                            self.track = track
                            tabBarDelegate?.maximizeTrackDetailsView(viewModel: track) // подумать что лучше передавать ? self.track : track
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

struct LibraryCell: View {
    
    var cell: SearchViewModel.Cell
    
    var body: some View {
        HStack {
            WebImage(url: URL(string: cell.iconStringUrl ?? ""))
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(5)
            VStack(alignment: .leading) {
                Text("\(cell.trackName)")
                Text("\(cell.artistName)")
            }
        }
        
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}
