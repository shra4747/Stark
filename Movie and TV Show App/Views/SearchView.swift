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
                Rectangle()
                    .foregroundColor(.init(hex: "EBEBEB"))
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    VStack(spacing: -20) {
                        HStack(spacing: 13) {
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 20)
                                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(.darkGray),lineWidth: 1))
                                    .frame(width: UIScreen.main.bounds.width - 70, height: 50)
                                    .foregroundColor(.white)
                                TextField("Search for anything...", text: $viewModel.query).padding(5)
                                    .frame(width: UIScreen.main.bounds.width - 120, alignment: .leading)
                                    .padding(.leading, 10)
                                    .font(.custom("Avenir", size: 17))
                            }
                            Button(action: {
                                viewModel.search()
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }) {
                                Image(systemName: "magnifyingglass")
                                    .scaleEffect(1.65)
                                    .foregroundColor(.black)
                                    
                            }
                        }.padding()
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
                    }.navigationBarHidden(true)
                    
                    if viewModel.selectedType == .movie {
                        if viewModel.movies.count != 0 {
                            ScrollView(.horizontal) {
                                HStack(alignment: .top, spacing: 30) {
                                    ForEach(viewModel.movies, id: \.self) { movie in
                                        NavigationLink(
                                            destination: MovieDetailView(id: movie.id, isGivingData: true, givingMovie: movie).navigationBarHidden(true),
                                            label: {
                                                VStack(alignment: .leading) {
                                                    Image(uiImage: movie.poster_path?.loadImage() ?? UIImage(imageLiteralResourceName: "questionmark"))
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
                                }.padding()
                            }
                        }
                        else {
                            VStack {
                                Image(systemName: "tv")
                                    .resizable()
                                    .frame(width: 90, height: 70)
                                    .foregroundColor(Color(.darkGray))
                                Text("Search for TV Shows \nor Movies!").multilineTextAlignment(.center)
                                    .font(.custom("Avenir", size: 22))
                            }.offset(y: UIScreen.main.bounds.height/2 - 190)
                        }
                    }
                    else {
                        if viewModel.shows.count != 0 {
                            ScrollView(.horizontal) {
                                HStack(alignment: .top, spacing: 30) {
                                    ForEach(viewModel.shows, id: \.self) { show in
                                        NavigationLink(
                                            destination: TVShowDetailView(id: show.id, isGivingData: true, givingShow: show).navigationBarHidden(true),
                                            label: {
                                                VStack(alignment: .leading) {
                                                    Image(uiImage: show.poster_path.loadImage())
                                                        .scaleEffect(0.65)
                                                        .frame(width: 296, height: 440)
                                                        .cornerRadius(18)
                                                        .shadow(color: Color(hex: "000000"), radius: 4, x: 0, y: 3)
                                                    Text(show.name)
                                                        .font(.custom("Avenir", size: 23))
                                                        .fontWeight(.bold)
                                                        .foregroundColor(.black)
                                                        .frame(width: 290, alignment: .leading)
                                                    
                                                    Text(viewModel.returnGenresText(for: show.genres))
                                                        .font(.custom("Avenir", size: 15))
                                                        .fontWeight(.medium)
                                                        .foregroundColor(Color(hex: "777777"))
                                                        .frame(width: 290, alignment: .leading)
                                                }
                                            })
                                    }
                                }.padding()
                            }
                        }
                        else {
                            VStack {
                                Image(systemName: "tv")
                                    .resizable()
                                    .frame(width: 90, height: 70)
                                    .foregroundColor(Color(.darkGray))
                                Text("Search for TV Shows \nor Movies!").multilineTextAlignment(.center)
                                    .font(.custom("Avenir", size: 22))
                            }.offset(y: UIScreen.main.bounds.height/2 - 190)
                        }
                    }
                    Spacer()
                }.padding(.top, 30)
            }
        }.background(Color(.lightGray))
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}


