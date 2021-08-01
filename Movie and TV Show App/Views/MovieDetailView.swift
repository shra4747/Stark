//
//  MovieDetailView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 7/31/21.
//

import SwiftUI

struct MovieDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel = MovieDetailViewModel()
    @State var id: Int
    
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
                        RoundedRectangle(cornerRadius: 34)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/1.5)
                            .edgesIgnoringSafeArea(.bottom)
                            .foregroundColor(.white)
                        Circle()
                            .frame(width: 75, height: 75)
                            .shadow(radius: 10)
                            .offset(y: -32)
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
                                                    destination: MovieDetailView(id: movie.id).navigationBarHidden(true),
                                                    label: {
                                                        VStack(alignment: .leading) {
                                                            VStack {
                                                                Image(uiImage: movie.poster_path?.loadImage() ?? UIImage())
                                                                    .scaleEffect(0.55)
                                                                    .frame(width: 250, height: 370)
                                                                    .cornerRadius(18)
                                                                    .shadow(radius: 5).id(UUID())
                                                            }.id(UUID())
                                                            Text(movie.title)
                                                                .font(.custom("Avenir", size: 23))
                                                                .fontWeight(.bold)
                                                                .foregroundColor(.black).id(UUID())
                                                        }.frame(width: 250, height: 400).id(UUID())
                                                })
                                            }
                                        }
                                    }
                                    .frame(minHeight: 410)
                                    .padding()
                                    .padding(.leading)
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
                                                    Image(uiImage: castmate.profile_path?.loadImage() ?? UIImage())
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
                                                        .frame(width: 140).id(UUID())
                                                    Text(castmate.character)
                                                        .font(.custom("Avenir", size: 15))
                                                        .fontWeight(.light)
                                                        .multilineTextAlignment(.center)
                                                        .frame(width: 140).id(UUID())
                                                }
                                            }
                                        }
                                    }
                                    .padding()
                                    .padding(.leading)
                                }
                            }
                        }.cornerRadius(40)
                        .padding(.top, 5)
                        .padding(.horizontal)
                    }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/1.5)
                }
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
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
                
                if viewModel.isLoading {
                    ZStack {
                        Color.white
                        ActivityIndicator(isAnimating: $viewModel.isLoading)
                    }
                }
                
            }
            .navigationBarHidden(true)
            .onAppear {
                viewModel.id = id
                viewModel.getMovieInfo()
            }
        }
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(id: 566525)
            .previewDevice("iPhone 12 mini")
    }
}
