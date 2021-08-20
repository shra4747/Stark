//
//  ChooseTVShowsView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/15/21.
//

import SwiftUI

struct ChooseTVShowsView: View {
    @State var genres: [Int]
    @State var shows: [SearchModel.TVShow] = []
    @State var selectedShows: [Int] = []
    @State var continueOnboarding = false
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationView {
            VStack {
                
                
                ScrollView(.vertical) {
                    Text("Tap Some Shows You Like!")
                        .font(.custom("Avenir", size: 28))
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center).padding()
                    LazyVStack {
                        ForEach(shows.uniqued().chunked(into: 2), id: \.self) { chunk in
                            HStack(spacing: 10) {
                                ForEach(chunk, id: \.self) { show in
                                    ChooseShowButtonView(selectedShows: $selectedShows, show: show)
                                }
                            }
                        }
                    }
                }
                
                Button(action: {
                    if selectedShows.count > 1 {
                        let encoded = try? JSONEncoder().encode(selectedShows)
                        UserDefaults.standard.set(encoded, forKey: "__ONBOARDING_SHOWS__")
                        UserDefaults.standard.set(true, forKey: "__FINISH__")
                        continueOnboarding.toggle()
                    }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 18)
                            .frame(width: UIScreen.main.bounds.width - 80, height: 50)
                            .foregroundColor(.black)
                            .shadow(radius: 4)
                        Text("Finish")
                            .font(.custom("Avenir", size: 22)).bold()
                            .foregroundColor(.white)
                    }
                }.padding()
                NavigationLink("", destination: TabView().navigationBarHidden(true), isActive: $continueOnboarding)
                .onAppear {
                    for genre in genres {
                        var url = SearchModel.APILinks.TVShow.TVShowForGenre
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
                                        for show in searchResult.results {
                                            getShowInfo(show.id)
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
    
    func getShowInfo(_ showID: Int) {
        var url = SearchModel.APILinks.TVShow.TVShowInfo
        url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
        url = url.replacingOccurrences(of: "{TVID}", with: "\(showID)")
        
        let request = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            }
            else {
                let response = try? JSONDecoder().decode(SearchModel.TVShow.self, from: data!)
                DispatchQueue.main.async {
                    if let response = response {
                        self.shows.append(response)
                    }
                }
            }
        }.resume()
    }
}

struct ChooseShowButtonView: View {
    
    @Binding var selectedShows: [Int]
    @State var show: SearchModel.TVShow
    @Environment(\.colorScheme) var colorScheme
    @State var clicked = false
    
    var body: some View {
        Button(action: {
            clicked.toggle()
            
            if clicked {
                selectedShows.append(show.id)
            }
            else {
                selectedShows = selectedShows.filter({ i in
                    i != show.id
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
                Image(uiImage: show.poster_path?.loadImage(type: .similar, colorScheme: (colorScheme == .light ? .light : .dark)) ?? getDefaultImage(type: .similar, colorScheme: (colorScheme == .light ? .light : .dark)))
                    .scaleEffect(((show.poster_path ?? "") == "" ? 1 : 0.37))
                    .shadow(radius: 5)
                    .frame(width: UIScreen.main.bounds.width / 2.2, height: 240)
                    .cornerRadius(18)
                Text(show.name)
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
