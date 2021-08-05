//
//  MovieDetailView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 7/31/21.
//

import SwiftUI

struct MovieDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = MovieDetailViewModel()
    @State var id: Int
    
    @State var isGivingData: Bool
    @State var givingMovie: SearchModel.Movie
    
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
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(viewModel.title)
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
                                            Text(viewModel.getRuntime())
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
                                    
                                    
                                    TrailerView(trailerYTLink: viewModel.trailerLink)
                                        .frame(width: 330, height: 190)
                                        .cornerRadius(18)
                                        .padding()
                                        .padding(.leading)
                                        .shadow(radius: 10)
                                    
                                    Rectangle()
                                        .frame(width: UIScreen.main.bounds.width - 20, height: 1, alignment: .center)
                                        .padding()
                                        .foregroundColor(.gray)
                                    
                                    if viewModel.watchProviders.count > 0 {
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text("Stream")
                                                .font(.custom("Avenir", size: 25))
                                                .fontWeight(.bold)
                                                .padding(.horizontal)
                                                .padding(.top)
                                                .padding(.leading)
                                            
                                            ScrollView(.horizontal, showsIndicators: false) {
                                                HStack(alignment: .top, spacing: 17) {
                                                    ForEach(viewModel.watchProviders[0].flatrate ?? [], id: \.self) { provider in
                                                        Image(uiImage: provider.logo_path.loadImage())
                                                            .resizable()
                                                            .frame(width: 70, height: 70)
                                                            .cornerRadius(18)
                                                            .shadow(radius: 3)
                                                    }
                                                }.frame(height: 75).padding(.leading).padding(.leading).padding(.trailing)
                                            }
                                        }.padding(.bottom)
                                    }
                                    
                                    if viewModel.watchProviders.count > 0 {
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text("Rent or Buy")
                                                .font(.custom("Avenir", size: 25))
                                                .fontWeight(.bold)
                                                .padding(.horizontal)
                                                .padding(.top)
                                                .padding(.leading)
                                            
                                            ScrollView(.horizontal, showsIndicators: false) {
                                                HStack(alignment: .top, spacing: 17) {
                                                    ForEach(viewModel.watchProviders[0].buy ?? [], id: \.self) { provider in
                                                        Image(uiImage: provider.logo_path.loadImage())
                                                            .resizable()
                                                            .frame(width: 70, height: 70)
                                                            .cornerRadius(18)
                                                            .shadow(radius: 3)
                                                    }
                                                }.frame(height: 75).padding(.leading).padding(.leading).padding(.trailing)
                                            }
                                        }.padding(.bottom)
                                    }
                                    
                                    Rectangle()
                                        .frame(width: UIScreen.main.bounds.width - 20, height: 1, alignment: .center)
                                        .padding()
                                        .foregroundColor(.gray)
                                    
                                    VStack(alignment: .leading) {
                                        Text("Similar Movies")
                                            .font(.custom("Avenir", size: 25))
                                            .fontWeight(.bold)
                                            .padding(.horizontal)
                                            .padding(.top)
                                            .padding(.leading)
                                        
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(spacing: 35) {
                                                ForEach(viewModel.similarMovies, id: \.self) { movie in
                                                    NavigationLink(
                                                        destination: MovieDetailView(id: movie.id, isGivingData: true, givingMovie: movie).navigationBarHidden(true),
                                                        label: {
                                                            VStack(alignment: .leading) {
                                                                VStack {
                                                                    Image(uiImage: movie.poster_path?.loadImage() ?? UIImage(imageLiteralResourceName: "questionmark"))
                                                                        .scaleEffect(0.55)
                                                                        .frame(width: 250, height: 370)
                                                                        .cornerRadius(18)
                                                                        .shadow(radius: 10).id(UUID())
                                                                }.id(UUID())
                                                                Text(movie.title)
                                                                    .font(.custom("Avenir", size: 23))
                                                                    .fontWeight(.bold)
                                                                    .foregroundColor(.black).id(UUID())
                                                            }
                                                    })
                                                }
                                            }.padding()
                                            .padding(.leading)
                                        }
                                        .padding(.bottom)
                                        .frame(height: 400)
                                        
                                    }
                                    
                                    Rectangle()
                                        .frame(width: UIScreen.main.bounds.width - 20, height: 1, alignment: .center)
                                        .padding()
                                        .foregroundColor(.gray)
                                    
                                    VStack(alignment: .leading) {
                                        Text("Cast")
                                            .font(.custom("Avenir", size: 25))
                                            .fontWeight(.bold)
                                            .padding(.horizontal)
                                            .padding(.top)
                                            .padding(.leading)
                                        
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack(alignment: .top) {
                                                ForEach(viewModel.cast, id: \.self) { castmate in
                                                    VStack(alignment: .center) {
                                                        Image(uiImage: castmate.profile_path?.loadImage() ?? UIImage(imageLiteralResourceName: "questionmark"))
                                                            .scaleEffect(0.3)
                                                            .frame(width: 150, height: 150)
                                                            .aspectRatio(contentMode: .fit)
                                                            .shadow(radius: 5)
                                                            .cornerRadius(18).id(UUID())
                                                        Text(castmate.name)
                                                            .font(.custom("Avenir", size: 16))
                                                            .fontWeight(.medium)
                                                            .foregroundColor(.init(hex: "262626"))
                                                            .multilineTextAlignment(.center)
                                                        Text(castmate.character)
                                                            .font(.custom("Avenir", size: 15))
                                                            .fontWeight(.light)
                                                            .multilineTextAlignment(.center)
                                                    }
                                                }
                                            }.padding()
                                            .padding(.leading)
                                        }
                                    }
                                }
                            }.cornerRadius(40)
                            .padding(.top, 5)
                            .padding(.horizontal)
                            
                            if viewModel.title != "" {
                                BookmarkButtonView(id: id, poster_path: viewModel.poster_path, title: viewModel.title, media_Type: .movie, release_date: viewModel.release_date).offset(y: -50)
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

                NavigationLink(
                    destination: BookmarkedDetailView(group: BookmarkModelDefaultGroups.watchLater),
                    label: {
                        ZStack {
                            Circle()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.white)
                                .shadow(radius: 10)
                            Image(systemName: "checkmark")
                                .foregroundColor(Color(.systemGray))
                        }
                    }).offset(x: (UIScreen.main.bounds.width/2 - 45), y: -(UIScreen.main.bounds.height/2 - 60))
                
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
                    viewModel.poster_path = givingMovie.poster_path ?? ""
                    viewModel.release_date = givingMovie.release_date
                    viewModel.getTrailer()
                    viewModel.getSimilarMovies()
                    viewModel.getCast()
                    viewModel.getWatchProviders()
                    viewModel.backdropImage = givingMovie.backdrop_path?.loadImage() ?? UIImage(imageLiteralResourceName: "questionmark")
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
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(id: 566525, isGivingData: false, givingMovie: SearchModel.EmptyModel.Movie)
    }
}


