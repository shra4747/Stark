//
//  MovieDetailView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 7/31/21.
//

import SwiftUI
import AlertToast

struct MovieDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = MovieDetailViewModel()
    @State var id: Int
    
    @State var isGivingData: Bool
    @State var givingMovie: SearchModel.Movie
    
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
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(viewModel.title)
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
                                            Text(viewModel.getRuntime())
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
                                    
                                    if viewModel.trailers.count > 0 {
                                        Text("Trailers / Videos")
                                            .font(.custom("Avenir", size: 22))
                                            .fontWeight(.bold)
                                            .padding(.horizontal)
                                            .padding(.top)
                                            .padding(.leading)
                                    }
                                    
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack(spacing: -20) {
                                            ForEach(viewModel.trailers.reversed(), id: \.self) { trailer in
                                                TrailerButtonView(trailer: trailer)
                                            }
                                        }
                                    }
//                                    TrailerView(trailerYTLink: viewModel.trailerLink)
//                                        .frame(width: 330, height: 190)
//                                        .cornerRadius(18)
//                                        .padding()
//                                        .padding(.leading)
//                                        .shadow(radius: 10)
                                    
                                    Separator()
                                    
                                    if viewModel.watchProviders.count > 0 {
                                        WatchProvidersView(watchProviders: viewModel.watchProviders)
                                    }
                                    
                                    VStack(alignment: .leading) {
                                        Text("Similar Movies")
                                            .font(.custom("Avenir", size: 25))
                                            .fontWeight(.bold)
                                            .padding(.horizontal)
                                            .padding(.top)
                                            .padding(.leading)
                                        
                                        if viewModel.similarMovies.count > 0 {
                                            MovieSimilarView(similarMovies: viewModel.similarMovies, shuffled: false)
                                                .frame(height: 400)

                                        }
                                        
                                    }
//                                    
                                    Separator()
//                                    
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
                                }.padding(.bottom, 60)
                            }.cornerRadius(40)
                            .padding(.top, 5)
                            .padding(.horizontal)
                            
                            if viewModel.title != "" {
                                BookmarkButtonView(id: id, poster_path: viewModel.poster_path, title: viewModel.title, media_Type: .movie, release_date: viewModel.release_date, canShowCountdown: true, showSaveToast: $showSavedToast).offset(y: -50)
                            }
                        }
                    }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/1.4)
                }
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
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
                
                
                if viewModel.similarMovies.count > 0 {
                    RatingButtonView(id: id, mediaType: .movie, showRatedToast: $showRatedToast).offset(x: (UIScreen.main.bounds.width/2 - 45), y: -(UIScreen.main.bounds.height/2 - 60))
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
            .toast(isPresenting: $showSavedToast, duration: 2, tapToDismiss: true) {
                AlertToast(displayMode: .alert, type: .complete(.green), title: "Saved!", subTitle: "Find \(viewModel.title) in the Saved Tab!", custom: .none)
            }
            .toast(isPresenting: $showRatedToast, duration: 2, tapToDismiss: true) {
                AlertToast(displayMode: .alert, type: .systemImage("star.fill", .yellow), title: "Rated!", subTitle: "", custom: .none)
            }
            .onAppear {
                if doneLoading {
                    return
                }

                if isGivingData {
                    // ViewModel.Publishers Data changed
                    viewModel.id = id
                    viewModel.poster_path = givingMovie.poster_path ?? ""
                    CountdownDate().findReleaseDate(movieID: givingMovie.id) { dateString in
                        DispatchQueue.main.async {
                            viewModel.release_date = dateString
                        }
                    }
                    viewModel.getTrailers()
                    viewModel.getSimilarMovies(type: .recommendation)
                    viewModel.getCast()
                    viewModel.getWatchProviders()
                    viewModel.backdropImage = givingMovie.backdrop_path?.loadImage(type: .episodes, colorScheme: (self.colorScheme == .light ? .light : .dark)) ?? UIImage()
                    viewModel.title = givingMovie.title
                    viewModel.genres = viewModel.returnGenresText(for: givingMovie.genres)
                    viewModel.runtime = "\(givingMovie.runtime ?? 0)"
                    viewModel.overview = givingMovie.overview
                    doneLoading = true

                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        viewModel.isLoading = false
                    }
                }
                else {
                    // Set view model id and get info
                    viewModel.id = id
                    viewModel.getMovieInfo()
                    doneLoading = true
                }
            }
        }.ignoresSafeArea(.keyboard)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(id: 299534, isGivingData: false, givingMovie: SearchModel.EmptyModel.Movie).preferredColorScheme(.light)
    }
}

struct Separator: View {
    var body: some View {
        Rectangle()
            .frame(width: UIScreen.main.bounds.width - 20, height: 1, alignment: .center)
            .padding()
            .foregroundColor(.gray)
    }
}

struct SimilarMoviesView: View {
    
    @State var similarMovies : [SearchModel.Movie]
    @State var shuffled: Bool
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 35) {
                ForEach(shuffled ? similarMovies.uniqued().shuffled() : similarMovies.uniqued(), id: \.self) { movie in
                    NavigationLink(
                        destination: MovieDetailView(id: movie.id, isGivingData: false, givingMovie: movie).navigationBarHidden(true),
                        label: {
                            VStack(alignment: .leading) {
                                VStack {
                                    Image(uiImage: ((movie.poster_path?.loadImage(type: .similar, colorScheme: (self.colorScheme == .light ? .light : .dark)) ?? (colorScheme == .light ? UIImage(named: "SimilarLight") : UIImage(named: "SimilarDark")))!))
                                        .scaleEffect(((movie.poster_path ?? "") == "" ? 1 : 0.580))
                                        .frame(width: 250, height: 370)
                                        .cornerRadius(18)
                                        .shadow(radius: 10)
                                }
                                Text(movie.title)
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

struct MovieSimilarView: View {
    
    @State var similarMovies : [SimilarMovies.SimilarMovie]
    @State var shuffled: Bool
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 35) {
                ForEach(shuffled ? similarMovies.uniqued().shuffled() : similarMovies.uniqued(), id: \.self) { movie in
                    NavigationLink(
                        destination: MovieDetailView(id: movie.id, isGivingData: false, givingMovie: SearchModel.EmptyModel.Movie).navigationBarHidden(true),
                        label: {
                            VStack(alignment: .leading) {
                                VStack {
                                    Image(uiImage: ((movie.poster_path?.loadImage(type: .similar, colorScheme: (self.colorScheme == .light ? .light : .dark)) ?? (colorScheme == .light ? UIImage(named: "SimilarLight") : UIImage(named: "SimilarDark")))!))
                                        .scaleEffect(((movie.poster_path ?? "") == "" ? 1 : 0.580))
                                        .frame(width: 250, height: 370)
                                        .cornerRadius(18)
                                        .shadow(radius: 10)
                                }
                                Text(movie.title)
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

struct WatchProvidersView: View {
    
    @State var watchProviders: [SearchModel.WatchProviders.Options]?
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        if let options = watchProviders?[0] {
            if let streaming = options.flatrate {
                if streaming.count > 0 {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Stream")
                            .font(.custom("Avenir", size: 25))
                            .fontWeight(.bold)
                            .padding(.horizontal)
                            .padding(.top)
                            .padding(.leading)
        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .top, spacing: 17) {
                                ForEach(streaming, id: \.self) { provider in
                                    Image(uiImage: provider.logo_path.loadImage(type: .cast, colorScheme: (self.colorScheme == .light ? .light : .dark)))
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .cornerRadius(18)
                                        .shadow(radius: 3)
                                }
                            }.frame(height: 75).padding(.leading).padding(.leading).padding(.trailing)
                        }
                    }.padding(.bottom)
                }
            }
        }
        
        if let options = watchProviders?[0] {
            if let rentOrBuy = options.buy {
                if rentOrBuy.count > 0 {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Rent or Buy")
                            .font(.custom("Avenir", size: 25))
                            .fontWeight(.bold)
                            .padding(.horizontal)
                            .padding(.top)
                            .padding(.leading)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .top, spacing: 17) {
                                ForEach(rentOrBuy, id: \.self) { provider in
                                    Image(uiImage: provider.logo_path.loadImage(type: .cast, colorScheme: (self.colorScheme == .light ? .light : .dark)))
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                        .cornerRadius(18)
                                        .shadow(radius: 3)
                                }
                            }.frame(height: 75).padding(.leading).padding(.leading).padding(.trailing)
                        }
                    }.padding(.bottom)
                }
            }
        }
        
        if let options = watchProviders?[0] {
            if let buy = options.buy {
                if let stream = options.flatrate {
                    if stream.count == 0 && buy.count == 0 {}
                    else {
                        Separator()

                    }
                }
            }
        }
    }
}

struct CastView: View {
    
    @State var cast: [SearchModel.Credits.Cast]
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(alignment: .top) {
                ForEach(cast, id: \.self) { castmate in
                    VStack(alignment: .center) {
                        Image(uiImage: castmate.profile_path?.loadImage(type: .cast, colorScheme: (self.colorScheme == .light ? .light : .dark)) ?? (colorScheme == .light ? UIImage(named: "SearchLight") : UIImage(named: "SearchDark"))!)
                            .scaleEffect(((castmate.profile_path ?? "") == "" ? 1 : 0.3))
                            .frame(width: 150, height: 150)
                            .aspectRatio(contentMode: .fit)
                            .shadow(radius: 5)
                            .cornerRadius(18).id(UUID())
                        ScrollView(.vertical, showsIndicators: false) {
                            Text(castmate.name)

                                .font(.custom("Avenir", size: 16))
                                .fontWeight(.medium)
                                .foregroundColor(.init(hex: colorScheme == .light ? "262626" : "F7F7F7"))
                                .multilineTextAlignment(.center)
                                .frame(width: 150)
                                .fixedSize(horizontal: false, vertical: true)
                            Text(castmate.character)
                                .font(.custom("Avenir", size: 15))
                                .fontWeight(.light)
                                .multilineTextAlignment(.center)
                                .frame(width: 145)
                                .fixedSize(horizontal: false, vertical: true).padding(.bottom, 15)
                        }
                    }.fixedSize(horizontal: false, vertical: false)

                }
            }.padding()
            .padding(.leading)
        }.padding(.top, -15)
        
    }
}
