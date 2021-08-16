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
    @State var selectedShows: [SearchModel.TVShow] = []
    @State var continueOnboarding = false
    var body: some View {
        NavigationView {
            VStack {
                Text("Tap Some Shows You Like!")
                    .font(.custom("Avenir", size: 28))
                    .fontWeight(.heavy)
                    .multilineTextAlignment(.center).padding()
                
                ScrollView(.vertical) {
                    LazyVStack {
                        ForEach(shows.uniqued().chunked(into: 2), id: \.self) { chunk in
                            HStack(spacing: 10) {
                                ForEach(chunk, id: \.self) { show in
                                    Button(action: {
                                        if selectedShows.contains(show) {
                                            if let index = selectedShows.firstIndex(of: show) {
                                                selectedShows.remove(at: index)
                                            }
                                        }
                                        else {
                                            selectedShows.append(show)
                                        }
                                    }) {
                                        VStack {
                                            Image(uiImage: show.poster_path?.loadImage() ?? SearchModel.EmptyModel.Image)
                                                .scaleEffect(0.37)
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
                                                    RoundedRectangle(cornerRadius: 18).foregroundColor(.black).frame(height: 240).opacity(selectedShows.contains(show) ? 0.6 : 0)
                                                    Spacer()
                                                }
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(.white)
                                                    .scaleEffect(2)
                                                    .offset(y: -15)
                                                    .opacity(selectedShows.contains(show) ? 1 : 0)
                                            }
                                        )
                                    }
                                }
                            }
                        }
                    }
                }
                
                Button(action: {
                    if selectedShows.count > 1 {
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
                let response = try! JSONDecoder().decode(SearchModel.TVShow.self, from: data!)
                DispatchQueue.main.async {
                    self.shows.append(response)
                }
            }
        }.resume()
    }
}
