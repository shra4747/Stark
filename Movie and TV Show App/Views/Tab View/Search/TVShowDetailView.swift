//
//  TVShowDetailView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/2/21.
//

import SwiftUI

struct TVShowDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = TVShowDetailViewModel()
    @State var id: Int
    
    @State var isGivingData: Bool
    @State var givingShow: SearchModel.TVShow
    
    @State var doneLoading = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Image(uiImage: viewModel.backdropImage)
                        .frame(width: UIScreen.main.bounds.width)
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    Spacer()
                }
                VStack {
                    Spacer()
                    ZStack {
                        
                        // MARK: Backing Rounded Rectangle
                        ZStack(alignment: .top) {
                            RoundedRectangle(cornerRadius: 34)
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/1.5)
                                .edgesIgnoringSafeArea(.bottom)
                                .foregroundColor(.white)
                                .shadow(radius: 4, x: 0, y: -4)
                        }
                        
                        
                        ZStack(alignment: .top) {
                            ScrollView(.vertical, showsIndicators: false) {
                                VStack(alignment: .leading, spacing: -10) {
                                    
                                    // MARK: Show Info
                                    Group {
                                        HStack {
                                            VStack(alignment: .leading) {
                                                Text(viewModel.name)
                                                    .font(.custom("Avenir", size: 30))
                                                    .fontWeight(.heavy)
                                                    .padding(.horizontal)
                                                    .padding(.top)
                                                    .padding(.leading)
                                                Text(viewModel.genres)
                                                    .font(.custom("Avenir", size: 18))
                                                    .fontWeight(.medium)
                                                    .padding(.leading)
                                                    .padding(.leading)
                                                    .foregroundColor(.init(hex: "777777"))
                                                Text("\(viewModel.number_of_seasons) seasons")
                                                    .font(.custom("Avenir", size: 16))
                                                    .fontWeight(.medium)
                                                    .padding(.leading)
                                                    .padding(.leading)
                                                    .foregroundColor(.init(hex: "5A5A5A"))
                                            }
                                            Spacer()
                                        }
                                        VStack {
                                            Text(viewModel.overview)
                                                .font(.custom("Avenir", size: 16))
                                                .bold()
                                                .fontWeight(.medium)
                                                .foregroundColor(.init(hex: "383838"))
                                                .padding()
                                                .padding(.leading)
                                        }
                                    }
                                    
                                    Text("Trailer")
                                        .font(.custom("Avenir", size: 22))
                                        .fontWeight(.bold)
                                        .padding(.horizontal)
                                        .padding(.top)
                                        .padding(.leading)
                                    
                                    // MARK: Trailer View
                                    TrailerView(trailerYTLink: viewModel.trailerLink)
                                        .frame(width: 330, height: 190)
                                        .cornerRadius(18)
                                        .padding()
                                        .padding(.leading)
                                        .shadow(radius: 10)
                                        .padding(.bottom, 20)
                                
                                    
                                    if viewModel.episodes.count > 0 {
                                        Text("Episodes")
                                            .font(.custom("Avenir", size: 22))
                                            .fontWeight(.bold)
                                            .padding(.horizontal)
                                            .padding(.top)
                                            .padding(.leading)
                                        EpisodesView(episodes: viewModel.episodes)
                                    }
                                  
                                    // MARK: Separator
                                    Separator()
                                    
                                    
                                    // MARK: Watch Providers
                                    if viewModel.watchProviders.count > 0 {
                                        WatchProvidersView(watchProviders: viewModel.watchProviders)
                                    }
                                    
                                    
                                    // MARK: Separator
//                                    Separator()
                                    
                                    
                                    // MARK: Similar Shows
                                    Group {
                                        VStack(alignment: .leading) {
                                            Text("Similar Shows")
                                                .font(.custom("Avenir", size: 25))
                                                .fontWeight(.bold)
                                                .padding(.horizontal)
                                                .padding(.top)
                                                .padding(.leading)
                                            
                                            
                                            if viewModel.similarShows.count > 0 {
                                                SimilarTVShowsView(similarShows: viewModel.similarShows)
                                            }
                                            
                                        }
                                    }
                                    
                                    
                                    // MARK: Separator
                                    Separator()
                                    
                                    
                                    // MARK: Cast
                                    Group {
                                        VStack(alignment: .leading) {
                                            Text("Cast")
                                                .font(.custom("Avenir", size: 25))
                                                .fontWeight(.bold)
                                                .padding(.horizontal)
                                                .padding(.top)
                                                .padding(.leading)
                                            
                                            if viewModel.cast.count > 0 {
                                                CastView(cast: viewModel.cast)
                                            }
                                        }
                                    }
                                }.padding(.bottom, 60)
                            }.cornerRadius(40)
                            .padding(.top, 5)
                            .padding(.horizontal)
                            
                            if viewModel.name != "" {
                                BookmarkButtonView(id: id, poster_path: viewModel.poster_path, title: viewModel.name, media_Type: .show, release_date: "").offset(y: -50)
                            }
                            
                        }
                    }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/1.5)
                }
                
                Button(action: {
                    DispatchQueue.main.async {
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    ZStack {
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                            .shadow(radius: 10)
                        Image(systemName: "arrow.left")
                            .foregroundColor(Color(.systemGray))
                    }
                }.offset(x: -(UIScreen.main.bounds.width/2 - 45), y: -(UIScreen.main.bounds.height/2 - 60))

                Button(action: {
                    
                }) {
                    ZStack {
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(.white)
                            .shadow(radius: 10)
                        Image(systemName: "checkmark")
                            .foregroundColor(Color(.systemGray))
                    }
                }.offset(x: (UIScreen.main.bounds.width/2 - 45), y: -(UIScreen.main.bounds.height/2 - 60))
                
                if viewModel.isLoading {
                    ZStack {
                        Color.white
                        ActivityIndicator(isAnimating: $viewModel.isLoading)
                    }.edgesIgnoringSafeArea(.top)
                }
                
            }
            .navigationBarHidden(true)
            .onAppear {
                if doneLoading {
                    return
                }
                
                if isGivingData {
                    // ViewModel.Publishers Data changed
                    viewModel.id = id
                    viewModel.poster_path = givingShow.poster_path ?? ""
                    viewModel.getTrailer()
                    viewModel.getSimilarShows(type: .recommendation)
                    viewModel.getCast()
                    viewModel.getWatchProviders()
                    viewModel.getEpisodes(season: 1)
                    viewModel.backdropImage = givingShow.backdrop_path?.loadImage() ?? SearchModel.EmptyModel.Image
                    viewModel.name = givingShow.name
                    viewModel.genres = viewModel.returnGenresText(for: givingShow.genres ?? [])
                    viewModel.number_of_seasons = "\(givingShow.number_of_seasons)"
                    viewModel.overview = givingShow.overview
                    
                    doneLoading = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        viewModel.isLoading = false
                    }
                }
                else {
                    // Set view model id and get info
                    viewModel.id = id
                    viewModel.getShowInfo()
                    doneLoading = true
                }
            }
        }
    }
}

struct TVShowDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TVShowDetailView(id: 100757, isGivingData: false, givingShow: SearchModel.EmptyModel.TVShow)
    }
}


struct EpisodesView: View {
    
    @State var episodes: [SearchModel.TVShow.Season.Episode]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top, spacing: 15) {
                ForEach(episodes, id: \.self) { episode in
                    VStack(alignment: .leading) {
                        VStack {
                            Image(uiImage: episode.still_path?.loadImage() ?? SearchModel.EmptyModel.Image)
                                .scaleEffect(0.6)
                                .frame(width: 220, height: 130)
                                .cornerRadius(18)
                                .shadow(radius: 5)
                        }.frame(height: 150).padding(.bottom, -2)
                        VStack(spacing: 4) {
                            Text(episode.name)
                                .font(.custom("Avenir", size: 16))
                                .fontWeight(.bold)
                                .frame(width: 220, alignment: .leading)
                                .padding(.leading, 1)
                            VStack {
                                Text(episode.overview)
                                    .font(.custom("Avenir", size: 14))
                                    .fontWeight(.light)
                                    .frame(width: 215, alignment: .leading)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.bottom, 20)
                            }
                        }
                    }
                }
//                RoundedRectangle(cornerRadius: 18)
//                    .foregroundColor(.white)
//                    .frame(width: 220, height: 130)
//                    .shadow(radius: 5)
            }.padding(.horizontal).padding()
        }
    }
}


struct SimilarTVShowsView: View {
    
    @State var similarShows: [SearchModel.TVShow]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 35) {
                ForEach(similarShows, id: \.self) { show in
                    NavigationLink(
                        destination: TVShowDetailView(id: show.id, isGivingData: true, givingShow: show).navigationBarHidden(true),
                        label: {
                            VStack(alignment: .leading) {
                                VStack {
                                    Image(uiImage: show.poster_path?.loadImage() ?? SearchModel.EmptyModel.Image)
                                        .scaleEffect(0.50)
                                        .frame(width: 250, height: 370)
                                        .cornerRadius(18)
                                        .shadow(radius: 10)
                                }
                                Text(show.name)
                                    .font(.custom("Avenir", size: 23))
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                            }
                    }).frame(width: 250, alignment: .leading)
                }
            }.padding()
            .padding(.leading)
            .frame(minHeight: 450)

        }
        .padding(.bottom)
        .frame(height: 400)
    }
}
