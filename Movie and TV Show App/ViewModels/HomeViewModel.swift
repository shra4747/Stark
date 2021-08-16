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
    
    init() {
        if self.isLoading == false { return }

        DispatchQueue.main.async {
            self.getRecommendedMovies()
        }
        DispatchQueue.main.async {
            self.getRecommendedShows()

        }
        DispatchQueue.main.async {
            self.getTrendingMovies()

        }
        DispatchQueue.main.async {
            self.getTrendingShows()

        }

        DispatchQueue.main.asyncAfter(deadline: .now()+1.5) {
            self.isLoading = false
        }
    }
    
    func getTrendingMovies() {
//        DispatchQueue.main.async {
            var url = SearchModel.APILinks.Movie.TrendingMovies
            url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
            
            let request = URLRequest(url: URL(string: url)!)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print(error)
                }
                else {
                    let response = try! JSONDecoder().decode(SearchModel.self, from: data!)
    //                DispatchQueue.main.async {
                        for movie in response.results {
    //                        DispatchQueue.main.async {
                                self.listTrendingMovies(movie.id)
    //                        }
                        }
    //                }
                }
            }.resume()
//        }
    }
    
    func getTrendingShows() {
//        DispatchQueue.main.async {
            var url = SearchModel.APILinks.TVShow.TrendingTVShows
            url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
            
            let request = URLRequest(url: URL(string: url)!)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print(error)
                }
                else {
                    let response = try! JSONDecoder().decode(SearchModel.self, from: data!)
    //                DispatchQueue.main.async {
                        for show in response.results {
    //                        DispatchQueue.main.async {
                                self.listTrendingShows(show.id)
    //                        }
                        }
    //                }
                }
            }.resume()
//        }
        
        
    }

    func getRecommendedMovies() {
        
//        DispatchQueue.main.async {
            var recMovies = RecommendationEngine().getMovieRecommendations().uniqued().shuffled()
        
        if recMovies.count < 2 {
            guard let data = UserDefaults.standard.value(forKey: "__ONBOARDING_MOVIES__") as? Data else {
                return
            }
            let onboardingMovies = try? JSONDecoder().decode([Int].self, from: data)
            for movie in onboardingMovies! {
                print(movie)
                recMovies.append(WRatedModel(id: movie, stars_rated: 0))
            }
        }
            
        
            for rmovie in recMovies {
                var url = SearchModel.APILinks.Movie.MovieRecommendations
                url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
                url = url.replacingOccurrences(of: "{MOVIEID}", with: "\(rmovie.id)")

                let request = URLRequest(url: URL(string: url)!)
                
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print(error)
                    }
                    else {
                        let response = try! JSONDecoder().decode(SearchModel.self, from: data!)
    //                    DispatchQueue.main.async {
                            for movie in response.results[...3] {
                                let generalModel = RecommendationEngine().getWatchedAndRated()
                                
                                let Cmovie = RecommendationEngine().checkInModel(stars: generalModel.movie, id: movie.id)
                                if Cmovie.wr {
                                    continue
                                }
    //                            DispatchQueue.main.async {
                                self.listMovies(movie.id)
    //                            }
                            }
    //                    }
                    }
                }.resume()
            }
//        }
        
    }
    
    func getRecommendedShows() {
//        DispatchQueue.main.async {
            var showRecs = RecommendationEngine().getShowRecommendations().uniqued().shuffled()
            
        if showRecs.count < 2 {
            guard let data = UserDefaults.standard.value(forKey: "__ONBOARDING_SHOWS__") as? Data else {
                return
            }
            let onboardingShows = try? JSONDecoder().decode([Int].self, from: data)
            for show in onboardingShows! {
                print(show)
                showRecs.append(WRatedModel(id: show, stars_rated: 0))
            }
        }
        
            for rshow in showRecs {
                var url = SearchModel.APILinks.TVShow.TVShowRecommendations
                url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
                url = url.replacingOccurrences(of: "{TVID}", with: "\(rshow.id)")
                let request = URLRequest(url: URL(string: url)!)
                
                URLSession.shared.dataTask(with: request) { data, response, error in
                    if let error = error {
                        print(error)
                    }
                    else {
                        let response = try! JSONDecoder().decode(SearchModel.self, from: data!)
    //                    DispatchQueue.main.async {
                            for show in response.results {
                                let generalModel = RecommendationEngine().getWatchedAndRated()
                                
                                let cShow = RecommendationEngine().checkInModel(stars: generalModel.show, id: show.id)
                                if cShow.wr {
                                    continue
                                }
    //                            DispatchQueue.main.async {
                                self.listShows(show.id)
    //                            }
                            }
    //                    }
                    }
                }.resume()
            }
//        }
        
        
    }
    
    func listTrendingMovies(_ id: Int) {
//        DispatchQueue.main.async {
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
//        }
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
                    self.recommendedMovies.append(response)
                }
            }
        }.resume()
    }
    
    func listTrendingShows(_ id: Int) {
//        DispatchQueue.main.async {
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
//    }
}
