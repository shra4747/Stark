//
//  TVShowDetailViewModel.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/2/21.
//

import Foundation
import SwiftUI
import UIKit

class TVShowDetailViewModel: ObservableObject {
    var id = 0
    
    @Published var isLoading = true
    var poster_path = ""
    @Published var backdropImage = UIImage()
    @Published var name = ""
    @Published var genres = ""
    @Published var number_of_seasons = ""
    @Published var overview = ""
    @Published var trailers: [SearchModel.Video.VideoInfo] = []
    @Published var similarShows: [SimilarShows.SimilarShow] = []
    @Published var cast: [SearchModel.Credits.Cast] = []
    @Published var watchProviders: [SearchModel.WatchProviders.Options] = []
    @Published var episodes: [SearchModel.TVShow.Season.Episode] = []
    @Environment(\.colorScheme) var colorScheme
    
    func getShowInfo() {
        var url = SearchModel.APILinks.TVShow.TVShowInfo
        url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
        url = url.replacingOccurrences(of: "{TVID}", with: "\(id)")
        
        let request = URLRequest(url: URL(string: url)!)
                
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            }
            else {
                let response = try! JSONDecoder().decode(SearchModel.TVShow.self, from: data!)
                DispatchQueue.main.async {
                    self.backdropImage = response.backdrop_path?.loadImage(type: .episodes, colorScheme: (self.colorScheme == .light ? .light : .dark)) ?? UIImage()
                    self.poster_path = response.poster_path ?? ""
                    self.name = response.name
                    self.genres = self.returnGenresText(for: response.genres ?? [])
                    self.number_of_seasons = "\(response.number_of_seasons)"
                    self.overview = response.overview
                    self.getSimilarShows(type: .recommendation)
                    self.getTrailers()
                    self.getCast()
                    self.getWatchProviders()
                    self.getEpisodes(season: 1)
                    self.isLoading = false
                }
            }
        }.resume()
    }
    
    func returnGenresText(for genres: [SearchModel.Genre]) -> String {
        var arrGenres: [String] = []
        
        for genre in genres {
            arrGenres.append(genre.name)
        }
        
        return arrGenres.joined(separator: ", ")
    }
    
    enum SimilarType {
        case recommendation, similar
    }
    
    func getSimilarShows(type: SimilarType) {
        func getShows() {
            var url = SearchModel.APILinks.TVShow.SimilarTVShows
            
            switch type {
            case .recommendation:
                url = SearchModel.APILinks.TVShow.TVShowRecommendations
            case .similar:
                url = SearchModel.APILinks.TVShow.SimilarTVShows
            }
            
            url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
            url = url.replacingOccurrences(of: "{TVID}", with: "\(id)")
            
            let request = URLRequest(url: URL(string: url)!)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print(error)
                }
                else {
                    let response = try! JSONDecoder().decode(SimilarShows.self, from: data!)
//
                    if response.results.count == 0 {
                        self.getSimilarShows(type: .similar)
                    }
                    else {
                        for show in response.results {
                            DispatchQueue.main.async {
                                self.similarShows.append(show)
                            }
                        }
                    }
                }
            }.resume()
        }
        getShows()
        
    }
    
    func getTrailers() {
        var url = SearchModel.APILinks.TVShow.TVShowVideos
        url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
        url = url.replacingOccurrences(of: "{TVID}", with: "\(id)")
        
        let request = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            }
            else {
                let response = try! JSONDecoder().decode(SearchModel.Video.self, from: data!)
                DispatchQueue.main.async {
                    for video in response.results {
                        if video.site.lowercased() == "youtube" {
                            self.trailers.append(video)
                        }
                    }
                }
            }
        }.resume()
    }
    
    func getWatchProviders() {
        var url = SearchModel.APILinks.TVShow.TVShowWatchProviders
        url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
        url = url.replacingOccurrences(of: "{TVID}", with: "\(id)")
        
        let request = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            }
            else {
                let response = try! JSONDecoder().decode(SearchModel.WatchProviders.self, from: data!)
                
                DispatchQueue.main.async {
                    for country in response.results {
                        if country.key == "US" {
                            self.watchProviders.append(country.value)
                        }
                    }
                    
                }
            }
        }.resume()
    }
    
    func getCast() {
        var url = SearchModel.APILinks.TVShow.TVShowCredits
        url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
        url = url.replacingOccurrences(of: "{TVID}", with: "\(id)")
        let request = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            }
            else {
                let response = try? JSONDecoder().decode(SearchModel.Credits.self, from: data!)
                DispatchQueue.main.async {
                    for castmate in response?.cast ?? [] {
                        self.cast.append(castmate)
                    }
                }
            }
        }.resume()
    }
    
    func getEpisodes(season: Int) {
        var url = SearchModel.APILinks.TVShow.TVShowEpisodesInSeason
        url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
        url = url.replacingOccurrences(of: "{TVID}", with: "\(id)")
        url = url.replacingOccurrences(of: "{SEASONID}", with: "\(season)")
        
        let request = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            }
            else {
                let response = try? JSONDecoder().decode(SearchModel.TVShow.Season.self, from: data!)
                
                DispatchQueue.main.async {
                    for episode in response?.episodes ?? [] {
                        self.episodes.append(episode)
                    }
                }
            }
        }.resume()
    }
}
