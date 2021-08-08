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
            ZStack {
                Rectangle()
                    .foregroundColor(.init(hex: "EBEBEB"))
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 18) {
                    VStack {
                        ZStack {
                            LinearGradient(gradient: Gradient(colors: group.gradient), startPoint: .topLeading, endPoint: .bottomTrailing).cornerRadius(30, corners: [.bottomLeft, .bottomRight])
                                .opacity(0.6)
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/4.2)
                                .edgesIgnoringSafeArea(.all)
                                .shadow(color: Color(.darkGray), radius: 8)
                            VStack(spacing: 20) {
                                Image(systemName: group.icon)
                                    .scaleEffect(3)
                                Text(group.name)
                                    .font(.custom("Avenir", size: 27))
                                    .fontWeight(.bold)

                            }.offset(y: -25)
                        }
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top, spacing: 20) {
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
                                                    .frame(width: 290, alignment: .leading)
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
                                                    .frame(width: 290, alignment: .leading)
                                            }
                                        })
                                }
                            }
                        }.padding()
                    }
                    Spacer()
                }.onAppear {
                    viewModel.load()
            }.navigationBarHidden(true)
            }
        }
    }
}

struct BookmarkedDetailView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        BookmarkedDetailView(group: BookmarkModelDefaultGroups.watchLater)
    }
}
