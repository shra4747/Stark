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
            VStack {
                TextField("Query", text: $viewModel.query).textFieldStyle(RoundedBorderTextFieldStyle()).padding(5)
                
                Button(action: {
                    viewModel.selectedType = .movie
                    viewModel.search()
                }) {
                    Text("Search")
                }
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(viewModel.movies, id: \.self) { movie in
                            NavigationLink(
                                destination: MovieDetailView(id: movie.id).navigationBarHidden(true),
                                label: {
                                    VStack(alignment: .leading) {
                                        Image(uiImage: movie.poster_path?.loadImage() ?? UIImage())
                                            .scaledToFill()
                                            .frame(width: 296, height: 440)
                                            .cornerRadius(18)
                                            .shadow(color: Color(hex: "000000"), radius: 5, x: 0, y: 3)
                                        Text(movie.title)
                                            .font(.custom("Avenir", size: 22))
                                            .fontWeight(.bold)
                                            .foregroundColor(.black)
                                            .frame(width: 290)
                                        
                                        Text(viewModel.returnGenresText(for: movie.genres))
                                            .font(.custom("Avenir", size: 11))
                                            .fontWeight(.medium)
                                            .foregroundColor(Color(hex: "777777"))
                                            .frame(width: 290)
                                    }
                                })
                        }
                    }
                }
            }.navigationBarHidden(true)
        }
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


