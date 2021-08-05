//
//  BookmarkedDetailView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/3/21.
//

import SwiftUI

struct BookmarkedDetailView: View {
    
    @State var group: BookmarkGroupModel
    @StateObject var viewModel = BookmarkedDetailViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Text(group.name)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.bookmarkedContent, id: \.self) { mediaContent in
                            if mediaContent.media_type == .movie {
                                NavigationLink(
                                    destination: MovieDetailView(id: mediaContent.id, isGivingData: false, givingMovie: SearchModel.EmptyModel.Movie).navigationBarHidden(true),
                                    label: {
                                        VStack(alignment: .leading) {
                                            Image(uiImage: mediaContent.poster_path.loadImage())
                                                .scaleEffect(0.65)
                                                .frame(width: 296, height: 440)
                                                .cornerRadius(18)
                                                .shadow(color: Color(hex: "000000"), radius: 5, x: 0, y: 3)
                                            Text(mediaContent.title)
                                                .font(.custom("Avenir", size: 22))
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                                .frame(width: 290)
                                        }
                                    })
                            }
                            else {
                                NavigationLink(
                                    destination: TVShowDetailView(id: mediaContent.id, isGivingData: false, givingShow: SearchModel.EmptyModel.TVShow).navigationBarHidden(true),
                                    label: {
                                        VStack(alignment: .leading) {
                                            Image(uiImage: mediaContent.poster_path.loadImage())
                                                .scaleEffect(0.65)
                                                .frame(width: 296, height: 440)
                                                .cornerRadius(18)
                                                .shadow(color: Color(hex: "000000"), radius: 5, x: 0, y: 3)
                                            Text(mediaContent.title)
                                                .font(.custom("Avenir", size: 22))
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                                .frame(width: 290)
                                        }
                                    })
                            }
                        }
                    }.padding()
                }
            }.onAppear {
                viewModel.load()
            }.navigationBarHidden(true)
        }
    }
}
