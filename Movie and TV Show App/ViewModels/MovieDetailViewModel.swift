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
    
    @Published var backdropImage = UIImage()
    @Published var title = ""
    @Published var genres = ""
    @Published var runtime = ""
    @Published var overview = ""
    @Published var trailerLink = ""
    @Published var similarMovies: [SearchModel.Movie] = []
    @Published var cast: [SearchModel.Credits.Cast] = []
    @Published var watchProviders: [SearchModel.WatchProviders.Options] = []
    
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
                    self.backdropImage = response.backdrop_path?.loadImage() ?? UIImage()
                    self.title = response.title
                    self.genres = self.returnGenresText(for: response.genres)
                    self.runtime = "\(response.runtime ?? 0)"
                    self.overview = response.overview
                    self.getSimilarMovies()
                    self.getTrailer()
                    self.getWatchProviders()
                    self.getCast()
                    self.isLoading = false

                }
            }
        }.resume()
    }
    
    func getSimilarMovies() {
        func getMovies() {
            var url = SearchModel.APILinks.Movie.SimilarMovies
            url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
            url = url.replacingOccurrences(of: "{MOVIEID}", with: "\(id)")
            
            let request = URLRequest(url: URL(string: url)!)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print(error)
                }
                else {
                    let response = try! JSONDecoder().decode(SearchModel.self, from: data!)
                    DispatchQueue.main.async {
                        for movie in response.results {
                            listMovies(movie.id)
                        }
                        
                    }
                }
            }.resume()
        }
        
        func listMovies(_ id: Int) {
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
                        self.similarMovies.append(response)
                    }
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
    
    func getTrailer() {
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
                    var key = ""
                    for video in response.results {
                        if video.type.lowercased() == "trailer" {
                            if video.site.lowercased() == "youtube" {
                                key = video.key
                            }
                        }
                    }
                    
                    if key == "" {
                        if response.results.count > 0 {
                            key = response.results[0].key
                        }
                        else {
                            key = "nil"
                        }
                    }
                    
                    self.trailerLink = "https://www.youtube.com/embed/\(key)"
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
