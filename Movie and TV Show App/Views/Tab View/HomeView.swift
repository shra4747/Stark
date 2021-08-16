//
//  HomeView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/13/21.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    @Environment(\.colorScheme) var colorScheme
    @State var showingSettings = false
    
    var name = UserDefaults.standard.value(forKey: "__NAME__")
    var avatar = getImage(key: "__AVATAR__")
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .foregroundColor(colorScheme == .light ? .init(hex: "EBEBEB") : .init(hex: "1A1A1A"))
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Hi, \(name as! String)")
                            .font(.custom("Avenir", size: 32))
                            .fontWeight(.bold)
                        Spacer()
                        Button(action: {
                            self.showingSettings.toggle()
                        }) {
                            
                            Image(uiImage: avatar!).resizable()
                                .clipShape(Circle()).frame(width: 54, height: 54, alignment: .center)
                                .shadow(radius: 5)
                        }
                        .sheet(isPresented: $showingSettings) {
                            SettingsView()
                        }
                        
                            
                    }.padding(.horizontal, 25).padding(.top, 45).padding(10)
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        Group {
                            HStack {
                                Text("Recommended Movies")
                                    .font(.custom("Avenir", size: 23))
                                    .fontWeight(.light)
                                    .frame(alignment: .leading)
                                    .padding(.horizontal, 25)
                                    .padding(.top)
                                    .padding(.bottom, 25)
                                Spacer()
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 35) {
                                    ForEach(viewModel.recommendedMovies.shuffled().uniqued(), id: \.self) { movie in
                                        NavigationLink(
                                            destination: MovieDetailView(id: movie.id, isGivingData: true, givingMovie: movie).navigationBarHidden(true),
                                            label: {
                                                VStack(alignment: .leading) {
                                                    VStack {
                                                        Image(uiImage: movie.poster_path?.loadImage() ?? SearchModel.EmptyModel.Image)
                                                            .scaleEffect(0.50)
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
                            
                            Separator().opacity(0.4)
                        }
                        
                        Group {
                            HStack {
                                Text("Recommended Shows")
                                    .font(.custom("Avenir", size: 23))
                                    .fontWeight(.light)
                                    .frame(alignment: .leading)
                                    .padding(.horizontal, 25)
                                    .padding(.top)
                                    .padding(.bottom, 25)
                                Spacer()
                            }
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 35) {
                                    ForEach(viewModel.recommendedShows.shuffled().uniqued(), id: \.self) { show in
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
                            
                            Separator().opacity(0.4)
                        }
                        
                        Group {
                            HStack {
                                Text("Trending Movies")
                                    .font(.custom("Avenir", size: 23))
                                    .fontWeight(.light)
                                    .frame(alignment: .leading)
                                    .padding(.horizontal, 25)
                                    .padding(.top)
                                    .padding(.bottom, 25)
                                Spacer()
                            }
                            
                            if viewModel.trendingMovies.count > 0 {
                                SimilarMoviesView(similarMovies: viewModel.trendingMovies, shuffled: false).frame(alignment: .leading)
                            }
                            
                            Separator().opacity(0.4)
                        }
                        
                        Group {
                            HStack {
                                Text("Trending Shows")
                                    .font(.custom("Avenir", size: 23))
                                    .fontWeight(.light)
                                    .frame(alignment: .leading)
                                    .padding(.horizontal, 25)
                                    .padding(.top)
                                    .padding(.bottom, 25)
                                Spacer()
                            }
                            
                            if viewModel.trendingShows.count > 0 {
                                SimilarTVShowsView(similarShows: viewModel.trendingShows, shuffled: false).frame(alignment: .leading).padding(.bottom, 100)
                            }
                            
                            
                        }
                        
                    }
                    
                    Spacer()
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
                
                
                
            }.navigationBarHidden(true)

        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .preferredColorScheme(.dark)
    }
}

