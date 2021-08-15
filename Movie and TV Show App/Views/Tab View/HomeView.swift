//
//  HomeView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/13/21.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .foregroundColor(.init(hex: "EBEBEB"))
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Hi, Shravan")
                            .font(.custom("Avenir", size: 32))
                            .fontWeight(.bold)
                        Spacer()
                        Circle()
                            .frame(width: 52, height: 52, alignment: .center)
                            .foregroundColor(.white)
                            .shadow(radius: 5)
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
                            
                            if viewModel.recommendedMovies.count > 0 {
                                SimilarMoviesView(similarMovies: viewModel.recommendedMovies, shuffled: true).frame(alignment: .leading)
                            }
                            
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
                            
                            if viewModel.recommendedShows.count > 0 {
                                SimilarTVShowsView(similarShows: viewModel.recommendedShows, shuffled: true).frame(alignment: .leading)
                            }
                            
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
                                SimilarTVShowsView(similarShows: viewModel.trendingShows, shuffled: true).frame(alignment: .leading).padding(.bottom, 100)
                            }
                            
                            
                        }
                        
                    }
                    
                    Spacer()
                }
                
                if viewModel.isLoading {
                    ZStack {
                        Color.white
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
    }
}

