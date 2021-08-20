//
//  TrailerView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 7/31/21.
//

import SwiftUI
import WebKit

struct TrailerButtonView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State var trailer: SearchModel.Video.VideoInfo
    @State var showTrailer = false
    
    var body: some View {
        Button(action: {
            self.showTrailer.toggle()
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: 18)
                    .frame(width: 250, height: 60)
                    .foregroundColor(colorScheme == .light ? .white : .black)
                    .padding()
                    .padding(.leading)
                    .shadow(color: colorScheme == .light ? Color(.sRGBLinear, white: 0, opacity: 0.33) : (.init(hex: "414141")), radius: 3)
                HStack {
                    Text(trailer.name)
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .font(.custom("Avenir", size: 17))
                        .fontWeight(.medium)
                        .frame(maxWidth: 200)
                        .frame(maxHeight: 50)
                    Image(systemName: "play")
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .scaleEffect(1.2)
                }
            }.sheet(isPresented: $showTrailer, content: {
                TrailerView(trailerYTLink: "https://www.youtube.com/watch?v=\(trailer.key)")
            })
        }
    }
}
import SafariServices

struct TrailerView : UIViewControllerRepresentable {
    
    let trailerYTLink: String
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<TrailerView>) -> SFSafariViewController {
            return SFSafariViewController(url: URL(string: trailerYTLink)!)
        }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<TrailerView>) {

    }
}
