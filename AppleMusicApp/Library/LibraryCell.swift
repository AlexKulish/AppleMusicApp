//
//  LibraryCell.swift
//  AppleMusicApp
//
//  Created by Alex Kulish on 14.10.2022.
//

import SwiftUI
import SDWebImageSwiftUI

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
