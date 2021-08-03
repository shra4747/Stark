//
//  ContentView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 7/28/21.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var viewModel = SearchViewModel()
    
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.lightGray)
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    ZStack {
                        HStack(spacing: 15) {
                            RoundedRectangle(cornerRadius: 20)
                                .frame(width: UIScreen.main.bounds.width - 80, height: 50)
                                .foregroundColor(.white)
                                
                            Image(systemName: "magnifyingglass")
                                .scaleEffect(1.7)
                        }
                        
                    }
                    Picker("", selection: $viewModel.selectedType) {
                        ForEach(SearchModel.MediaType.allCases) { mediaType in
                            if mediaType == .show {
                                Text("TV \(mediaType.displayName)s")
                                    .font(.custom("Avenir", size: 14))
                                    .tag(mediaType)
                            }
                            else {
                                Text("\(mediaType.displayName)s")
                                    .font(.custom("Avenir", size: 14))
                                    .tag(mediaType)
                            }
                        }
                    }.pickerStyle(SegmentedPickerStyle()).padding()
                    TextField("Query", text: $viewModel.query).textFieldStyle(RoundedBorderTextFieldStyle()).padding(5)

                    Button(action: {
                        viewModel.search()
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }) {
                        Text("Search")
                    }
                    
                    
                    
                    if viewModel.selectedType == .movie {
                        ScrollView(.horizontal) {
                            HStack(spacing: 30) {
                                ForEach(viewModel.movies, id: \.self) { movie in
                                    NavigationLink(
                                        destination: MovieDetailView(id: movie.id, isGivingData: true, givingMovie: movie).navigationBarHidden(true),
                                        label: {
                                            VStack(alignment: .leading) {
                                                Image(uiImage: movie.poster_path?.loadImage() ?? UIImage())
                                                    .scaleEffect(0.65)
                                                    .frame(width: 296, height: 440)
                                                    .cornerRadius(18)
                                                    .shadow(color: Color(hex: "000000"), radius: 5, x: 0, y: 3)
                                                Text(movie.title)
                                                    .font(.custom("Avenir", size: 22))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.black)
                                                    .frame(width: 290)
                                                
                                                Text(viewModel.returnGenresText(for: movie.genres))
                                                    .font(.custom("Avenir", size: 16))
                                                    .fontWeight(.medium)
                                                    .foregroundColor(Color(hex: "777777"))
                                                    .frame(width: 290)
                                            }
                                        })
                                }
                            }
                        }.padding()
                    }
                    else {
                        ScrollView(.horizontal) {
                            HStack(spacing: 30) {
                                ForEach(viewModel.shows, id: \.self) { show in
                                    NavigationLink(
                                        destination: TVShowDetailView(id: show.id, isGivingData: true, givingShow: show).navigationBarHidden(true),
                                        label: {
                                            VStack(alignment: .leading) {
                                                Image(uiImage: show.poster_path.loadImage())
                                                    .scaleEffect(0.65)
                                                    .frame(width: 296, height: 440)
                                                    .cornerRadius(18)
                                                    .shadow(color: Color(hex: "000000"), radius: 5, x: 0, y: 3)
                                                Text(show.name)
                                                    .font(.custom("Avenir", size: 22))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.black)
                                                    .frame(width: 290)
                                                
                                                Text(viewModel.returnGenresText(for: show.genres))
                                                    .font(.custom("Avenir", size: 16))
                                                    .fontWeight(.medium)
                                                    .foregroundColor(Color(hex: "777777"))
                                                    .frame(width: 290)
                                            }
                                        })
                                }
                            }
                        }.padding()
                    }
                }.navigationBarHidden(true)
            }
        }.background(Color(.lightGray))
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


