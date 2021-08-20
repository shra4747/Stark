//
//  TVShowDetailView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/2/21.
//

import SwiftUI
import AlertToast

struct TVShowDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = TVShowDetailViewModel()
    @State var id: Int
    
    @State var isGivingData: Bool
    @State var givingShow: SearchModel.TVShow
    
    @State var doneLoading = false
    @Environment(\.colorScheme) var colorScheme
    @State var showSavedToast = false
    @State var showRatedToast = false
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
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/1.4)
                                .edgesIgnoringSafeArea(.bottom)
                                .foregroundColor(colorScheme == .light ? .init(hex: "FFFFFF") : .init(hex: "1A1A1A"))
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
                                                    .fixedSize(horizontal: false, vertical: true)

                                                Text(viewModel.genres)
                                                    .font(.custom("Avenir", size: 18))
                                                    .fontWeight(.medium)
                                                    .padding(.leading)
                                                    .padding(.leading)
                                                    .foregroundColor(.init(hex: colorScheme == .light ? "777777" : "C1C1C1"))
                                                    .fixedSize(horizontal: false, vertical: true)

                                                Text("\(viewModel.number_of_seasons) seasons")
                                                    .font(.custom("Avenir", size: 16))
                                                    .fontWeight(.medium)
                                                    .padding(.leading)
                                                    .padding(.leading)
                                                    .foregroundColor(.init(hex: colorScheme == .light ? "5A5A5A" : "AAAAAA"))
                                            }
                                            Spacer()
                                        }
                                        VStack {
                                            Text(viewModel.overview)
                                                .font(.custom("Avenir", size: 16))
                                                .bold()
                                                .fontWeight(.medium)
                                                .foregroundColor(.init(hex: colorScheme == .light ? "383838" : "DEDEDE"))
                                                .padding()
                                                .padding(.leading)
                                                .fixedSize(horizontal: false, vertical: true)

                                        }
                                    }
                                    
                                    if viewModel.trailers.count > 0 {
                                        Text("Trailers / Videos")
                                            .font(.custom("Avenir", size: 22))
                                            .fontWeight(.bold)
                                            .padding(.horizontal)
                                            .padding(.top)
                                            .padding(.leading)
                                    }
                                    
                                    // MARK: Trailer View
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: -20) {
                                            ForEach(viewModel.trailers.reversed(), id: \.self) { trailer in
                                                TrailerButtonView(trailer: trailer)
                                            }
                                        }
                                    }
                                
                                    
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
                                                ShowSimilarView(similarMovies: viewModel.similarShows, shuffled: true)                                                .frame(height: 400)

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
                                BookmarkButtonView(id: id, poster_path: viewModel.poster_path, title: viewModel.name, media_Type: .show, release_date: "", canShowCountdown: false, showSaveToast: $showSavedToast).offset(y: -50)
                            }
                            
                        }
                    }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/1.4)
                }
                
                Button(action: {
                    DispatchQueue.main.async {
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    ZStack {
                        Circle()
                            .frame(width: 40, height: 40)
                            .foregroundColor(colorScheme == .light ? .white : .black)
                            .shadow(radius: 10)
                        Image(systemName: "arrow.left")
                            .foregroundColor(colorScheme == .light ? Color(.systemGray) : Color(.lightGray))
                    }
                }.offset(x: -(UIScreen.main.bounds.width/2 - 45), y: -(UIScreen.main.bounds.height/2 - 60))

                if viewModel.similarShows.count > 0 {
                    RatingButtonView(id: id, mediaType: .show, showRatedToast: $showRatedToast).offset(x: (UIScreen.main.bounds.width/2 - 45), y: -(UIScreen.main.bounds.height/2 - 60))
                }
                
                if viewModel.isLoading {
                    ZStack {
                        if colorScheme == .light {
                            Color.white
                        }
                        else {
                            Color.init(hex: "1A1A1A")
                        }
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
                    viewModel.getTrailers()
                    viewModel.getCast()
                    viewModel.getWatchProviders()
                    viewModel.getEpisodes(season: 1)
                    viewModel.backdropImage = givingShow.backdrop_path?.loadImage(type: .similar, colorScheme: (self.colorScheme == .light ? .light : .dark)) ?? UIImage()
                    viewModel.name = givingShow.name
                    viewModel.genres = viewModel.returnGenresText(for: givingShow.genres ?? [])
                    viewModel.number_of_seasons = "\(givingShow.number_of_seasons)"
                    viewModel.overview = givingShow.overview
                    viewModel.getSimilarShows(type: .recommendation)
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
            .preferredColorScheme(.dark)
    }
}


struct EpisodesView: View {
    
    @State var episodes: [SearchModel.TVShow.Season.Episode]
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top, spacing: 15) {
                ForEach(episodes, id: \.self) { episode in
                    VStack(alignment: .leading) {
                        VStack {
                            Image(uiImage: episode.still_path?.loadImage(type: .similar, colorScheme: (self.colorScheme == .light ? .light : .dark)) ?? (colorScheme == .light ? UIImage(named: "EpisodesLight") : UIImage(named: "EpisodesDark"))!)
                                .scaleEffect(((episode.still_path ?? "") == "" ? 1 : 0.6))
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
                            ScrollView(.vertical, showsIndicators: false) {
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

            }.padding(.horizontal).padding()
        }
    }
}


struct SimilarTVShowsView: View {
    
    @State var similarShows: [SearchModel.TVShow]
    @State var shuffled: Bool
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 35) {
                ForEach(shuffled ? similarShows.uniqued().shuffled() : similarShows.uniqued(), id: \.self) { show in
                    NavigationLink(
                        destination: TVShowDetailView(id: show.id, isGivingData: false, givingShow: show).navigationBarHidden(true),
                        label: {
                            VStack(alignment: .leading) {
                                VStack {
                                    Image(uiImage: ((show.poster_path?.loadImage(type: .similar, colorScheme: (colorScheme == .light ? .light : .dark)) ?? (colorScheme == .light ? UIImage(named: "SimilarLight") : UIImage(named: "SimilarDark")))!))
                                        .scaleEffect(((show.poster_path ?? "") == "" ? 1 : 0.5))
                                        .frame(width: 250, height: 370)
                                        .cornerRadius(18)
                                        .shadow(radius: 10)
                                }
                                Text(show.name)
                                    .font(.custom("Avenir", size: 23))
                                    .fontWeight(.bold)
                                    .foregroundColor(colorScheme == .light ? .black : .white)
                            }
                    }).frame(width: 250, alignment: .leading)
                }
            }.padding()
            .padding(.leading)
            .frame(minHeight: 450).id(UUID())

        }
        .padding(.bottom)
        .frame(height: 400)
    }
}

struct ShowSimilarView: View {
    
    @State var similarMovies : [SimilarShows.SimilarShow]
    @State var shuffled: Bool
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 35) {
                ForEach(shuffled ? similarMovies.uniqued().shuffled() : similarMovies.uniqued(), id: \.self) { movie in
                    NavigationLink(
                        destination: TVShowDetailView(id: movie.id, isGivingData: false, givingShow: SearchModel.EmptyModel.TVShow).navigationBarHidden(true),
                        label: {
                            VStack(alignment: .leading) {
                                VStack {
                                    Image(uiImage: ((movie.poster_path?.loadImage(type: .similar, colorScheme: (self.colorScheme == .light ? .light : .dark)) ?? (colorScheme == .light ? UIImage(named: "SimilarLight") : UIImage(named: "SimilarDark")))!))
                                        .scaleEffect(((movie.poster_path ?? "") == "" ? 1 : 0.50))
                                        .frame(width: 250, height: 370)
                                        .cornerRadius(18)
                                        .shadow(radius: 10)
                                }
                                Text(movie.name)
                                    .font(.custom("Avenir", size: 20))
                                    .fontWeight(.bold)
                                    .foregroundColor(colorScheme == .light ? .black : .white)

                                    
                            }
                    }).frame(width: 250, alignment: .leading)

                }
            }.padding()
            .padding(.leading)
            .frame(minHeight: 450).id(UUID())

        }
        .padding(.bottom)
        .frame(height: 400)
    }
}
