//
//  MovieDetailViewModel.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 7/31/21.
//

import Foundation
import SwiftUI
import UIKit

class MovieDetailViewModel: ObservableObject {
    
    var id = 0

    @Published var isLoading = true
    var poster_path = ""
    @Published var backdropImage = UIImage()
    @Published var title = ""
    @Published var genres = ""
    @Published var runtime = ""
    @Published var release_date = ""
    @Published var overview = ""
    @Published var trailers: [SearchModel.Video.VideoInfo] = []
    @Published var similarMovies: [SimilarMovies.SimilarMovie] = []
    @Published var cast: [SearchModel.Credits.Cast] = []
    @Published var watchProviders: [SearchModel.WatchProviders.Options] = []
    @Environment(\.colorScheme) var colorScheme
    
    func getMovieInfo() {
        var url = SearchModel.APILinks.Movie.MovieInfo
        url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
        url = url.replacingOccurrences(of: "{MOVIEID}", with: "\(id)")
        
        let request = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            }
            else {
                let response = try! JSONDecoder().decode(SearchModel.Movie.self, from: data!)
                DispatchQueue.main.async {
                    self.backdropImage = response.backdrop_path?.loadImage(type: .episodes, colorScheme: (self.colorScheme == .light ? .light : .dark)) ?? UIImage()
                    self.poster_path = response.poster_path ?? ""
                    self.title = response.title
                    
                    CountdownDate().findReleaseDate(movieID: response.id) { dateString in
                        DispatchQueue.main.async {
                            self.release_date = dateString
                        }
                    }
                    
                    self.genres = self.returnGenresText(for: response.genres)
                    self.runtime = "\(response.runtime ?? 0)"
                    self.overview = response.overview
                    self.getSimilarMovies(type: .recommendation)
                    self.getTrailers()
                    self.getWatchProviders()
                    self.getCast()
                    self.isLoading = false
                }
            }
        }.resume()
    }
    
    enum SimilarType {
        case recommendation, similar
    }
    
    func getSimilarMovies(type: SimilarType) {
        func getMovies() {
            var url = SearchModel.APILinks.Movie.MovieRecommendations
            
            switch type {
            case .recommendation:
                url = SearchModel.APILinks.Movie.MovieRecommendations
            case .similar:
                url = SearchModel.APILinks.Movie.SimilarMovies
            }
            
            url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
            url = url.replacingOccurrences(of: "{MOVIEID}", with: "\(id)")
            
            let request = URLRequest(url: URL(string: url)!)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print(error)
                }
                else {
                    let response = try! JSONDecoder().decode(SimilarMovies.self, from: data!)
//
                    if response.results.count == 0 {
                        self.getSimilarMovies(type: .similar)
                    }
                    else {
                        for movie in response.results {
                            DispatchQueue.main.async {
                                self.similarMovies.append(movie)
                            }
                        }
                    }
//
                }
            }.resume()
        }
        
        getMovies()
    }
    
    func getCast() {
        var url = SearchModel.APILinks.Movie.MovieCredits
        url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
        url = url.replacingOccurrences(of: "{MOVIEID}", with: "\(id)")
        
        let request = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            }
            else {
                let response = try! JSONDecoder().decode(SearchModel.Credits.self, from: data!)
                DispatchQueue.main.async {
                    for castmate in response.cast {
                        self.cast.append(castmate)
                    }
                }
            }
        }.resume()
    }
    
    func getTrailers() {
        var url = SearchModel.APILinks.Movie.MovieVideos
        url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
        url = url.replacingOccurrences(of: "{MOVIEID}", with: "\(id)")
        
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
        var url = SearchModel.APILinks.Movie.MovieWatchProviders
        url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
        url = url.replacingOccurrences(of: "{MOVIEID}", with: "\(id)")
        
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
    
    func returnGenresText(for genres: [SearchModel.Genre]) -> String {
        
        var arrGenres: [String] = []
        
        for genre in genres {
            arrGenres.append(genre.name)
        }
        
        return arrGenres.joined(separator: ", ")
    }
    
    func getRuntime() -> String {
        if title == "" {
            return ""
        }
        
        if runtime == "0" {
            return "Unknown Runtime"
        }
        else {
            return "\(runtime)mins"
        }
    }
}

struct SimilarMovies: Codable, Hashable {
    let results: [SimilarMovie]
    
    struct SimilarMovie: Codable, Hashable {
        let id: Int
        let poster_path: String?
        let title: String
    }
}

struct SimilarShows: Codable, Hashable {
    let results: [SimilarShow]
    
    struct SimilarShow: Codable, Hashable {
        let id: Int
        let poster_path: String?
        let name: String
    }
}
