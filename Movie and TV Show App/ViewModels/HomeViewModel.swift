//
//  HomeViewModel.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/13/21.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var isLoading = true
    @Published var recommendedMovies: [SearchModel.Movie] = []
    @Published var recommendedShows: [SearchModel.TVShow] = []
    
    @Published var trendingMovies: [SearchModel.Movie] = []
    @Published var trendingShows: [SearchModel.TVShow] = []
    var id = 299534
    
    init() {
        if isLoading == false { return }
        self.getRecommendedMovies()
        self.getRecommendedShows()
        self.getTrendingMovies()
        self.getTrendingShows()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
            self.isLoading = false
        }
    }
    
    func getTrendingMovies() {
        var url = SearchModel.APILinks.Movie.TrendingMovies
        url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
        
        let request = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            }
            else {
                let response = try! JSONDecoder().decode(SearchModel.self, from: data!)
                for movie in response.results {
                    DispatchQueue.main.async {
                        self.listTrendingMovies(movie.id)
                    }
                }
            }
        }.resume()
    }
    
    func getTrendingShows() {
        var url = SearchModel.APILinks.TVShow.TrendingTVShows
        url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
        
        let request = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            }
            else {
                let response = try! JSONDecoder().decode(SearchModel.self, from: data!)
                for show in response.results {
                    DispatchQueue.main.async {
                        self.listTrendingShows(show.id)
                    }
                }
            }
        }.resume()
        
        
    }

    func getRecommendedMovies() {
        var url = SearchModel.APILinks.Movie.MovieRecommendations
        url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
        url = url.replacingOccurrences(of: "{MOVIEID}", with: "\(id)")
        
        let request = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            }
            else {
                let response = try! JSONDecoder().decode(SearchModel.self, from: data!)
                for movie in response.results {
                    DispatchQueue.main.async {
                        listMovies(movie.id)
                    }
                }
            }
        }.resume()
        
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
                        self.recommendedMovies.append(response)
                    }
                }
            }.resume()
        }
    }
    
    func getRecommendedShows() {
        var url = SearchModel.APILinks.TVShow.TVShowRecommendations
        url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
        url = url.replacingOccurrences(of: "{TVID}", with: "84958")
        
        let request = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            }
            else {
                let response = try! JSONDecoder().decode(SearchModel.self, from: data!)
                for show in response.results {
                    DispatchQueue.main.async {
                        listShows(show.id)
                    }
                }
            }
        }.resume()
        
        func listShows(_ id: Int) {
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
                        self.recommendedShows.append(response)
                    }
                }
            }.resume()
        }
    }
    
    func listTrendingMovies(_ id: Int) {
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
                    self.trendingMovies.append(response)
                }
            }
        }.resume()
    }
    
    func listTrendingShows(_ id: Int) {
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
                    self.trendingShows.append(response)
                }
            }
        }.resume()
    }
}
