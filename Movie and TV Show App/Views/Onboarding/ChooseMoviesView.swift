//
//  ChooseMoviesView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/15/21.
//

import SwiftUI

struct ChooseMoviesView: View {
    
    @State var genres: [Int]
    @State var movies: [SearchModel.Movie] = []
    @State var selectedMovies: [Int] = []
    @State var continueOnboarding = false
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            VStack {
                    
                    
                    ScrollView(.vertical) {
                        Text("Tap Some Movies You Like!")
                            .font(.custom("Avenir", size: 28))
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.center).padding()
                        LazyVStack {
                            ForEach(movies.uniqued().chunked(into: 2), id: \.self) { chunk in
                                HStack(spacing: 10) {
                                    ForEach(chunk, id: \.self) { movie in
                                        ChooseMovieButtonView(selectedMovies: $selectedMovies, movie: movie)
                                    }
                                }
                            }
                        }
                    }
                    
                    Button(action: {
                        if selectedMovies.count > 1 {
                            let encoded = try? JSONEncoder().encode(selectedMovies)
                            UserDefaults.standard.set(encoded, forKey: "__ONBOARDING_MOVIES__")
                            
                            continueOnboarding.toggle()
                        }
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 18)
                                .frame(width: UIScreen.main.bounds.width - 80, height: 50)
                                .foregroundColor(.black)
                                .shadow(radius: 4)
                            Text("Next")
                                .font(.custom("Avenir", size: 22)).bold()
                                .foregroundColor(.white)
                        }
                    }.padding()
                    NavigationLink("", destination: ChooseTVShowGenresView().navigationBarHidden(true), isActive: $continueOnboarding)
                    .onAppear {
                        for genre in genres {
                            var url = SearchModel.APILinks.Movie.MovieForGenre
                            url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
                            url = url.replacingOccurrences(of: "{GENRES}", with: "\(genre)")
                            let request = URLRequest(url: URL(string: url)!)
                            
                            DispatchQueue.main.async {
                                URLSession.shared.dataTask(with: request) { data, response, error in
                                    if let error = error {
                                        print(error)
                                    }
                                    else {
                                        let searchResult = try! JSONDecoder().decode(SearchModel.self, from: data!)
                                        DispatchQueue.main.async {
                                            for movie in searchResult.results {
                                                getMovieInfo(movie.id)
                                            }
                                        }
                                    }
                                }.resume()
                            }
                        }
                        
                        
                        
                    }
            }.navigationBarHidden(true)
        }
    }
    
    func getMovieInfo(_ movieID: Int) {
        var url = SearchModel.APILinks.Movie.MovieInfo
        url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
        url = url.replacingOccurrences(of: "{MOVIEID}", with: "\(movieID)")
        
        let request = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            }
            else {
                let response = try? JSONDecoder().decode(SearchModel.Movie.self, from: data!)
                DispatchQueue.main.async {
                    if let response = response {
                        self.movies.append(response)
                    }
                }
            }
        }.resume()
    }
}

struct ChooseMovieButtonView: View {
    
    @Binding var selectedMovies: [Int]
    @State var movie: SearchModel.Movie
    @Environment(\.colorScheme) var colorScheme
    @State var clicked = false
    
    var body: some View {
        Button(action: {
            clicked.toggle()
            
            if clicked {
                selectedMovies.append(movie.id)
            }
            else {
                selectedMovies = selectedMovies.filter({ i in
                    i != movie.id
                })
            }
            
//            if selectedMovies.contains(movie.id) {
//                if let index = selectedMovies.firstIndex(of: movie.id) {
//                    selectedMovies.remove(at: index)
//                }
//            }
//            else {
//                selectedMovies.append(movie.id)
//            }
        }) {
            VStack {
                Image(uiImage: movie.poster_path?.loadImage(type: .similar, colorScheme: (colorScheme == .light ? .light : .dark)) ?? getDefaultImage(type: .similar, colorScheme: (colorScheme == .light ? .light : .dark)))
                    .scaleEffect(((movie.poster_path ?? "") == "" ? 1 : 0.37))
                    .shadow(radius: 5)
                    .frame(width: UIScreen.main.bounds.width / 2.2, height: 240)
                    .cornerRadius(18)
                Text(movie.title)
                    .foregroundColor(.black)
                    .font(.custom("Avenir", size: 18)).bold()
                    .frame(width: UIScreen.main.bounds.width / 2.2, alignment: .leading)
            }.overlay(
                ZStack {
                    VStack {
                        RoundedRectangle(cornerRadius: 18).foregroundColor(.black).frame(height: 240).opacity(clicked ? 0.6 : 0)
                        Spacer()
                    }
                    Image(systemName: "checkmark")
                        .foregroundColor(.white)
                        .scaleEffect(2)
                        .offset(y: -15)
                        .opacity(clicked ? 1 : 0)
                }
            )
        }
    }
}
