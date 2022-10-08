//
//  Library.swift
//  AppleMusicApp
//
//  Created by Alex Kulish on 08.10.2022.
//

import SwiftUI

struct Library: View {
    var body: some View {
        VStack {
            GeometryReader { geometry in
                HStack(spacing: 20) {
                    Button {
                        print("12345")
                    } label: {
                        Image(systemName: "play.fill")
                            .frame(width: geometry.size.width / 2 - 10, height: 50)
                            .accentColor(.init(#colorLiteral(red: 1, green: 0.2823529412, blue: 0.4078431373, alpha: 1)))
                            .background(Color.init(.systemGray6))
                            .cornerRadius(10)
                    }
                    Button {
                        print("54321")
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
                LibraryCell()
                Text("one")
                Text("two")
            }
        }
    }
}

struct LibraryCell: View {
    var body: some View {
        HStack {
            Image("Image")
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(5)
            VStack {
                Text("Track name")
                Text("Artist name")
            }
        }
        
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}
