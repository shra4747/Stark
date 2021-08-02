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
    
    @Published var backdropImage = UIImage()
    @Published var name = ""
    @Published var genres = ""
    @Published var number_of_seasons = ""
    @Published var overview = ""
    @Published var trailerLink = ""
    @Published var similarShows: [SearchModel.TVShow] = []
    @Published var cast: [SearchModel.Credits.Cast] = []
    @Published var watchProviders: [SearchModel.WatchProviders.Options] = []
    
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
                    self.backdropImage = response.backdrop_path?.loadImage() ?? UIImage()
                    self.name = response.name
                    self.genres = self.returnGenresText(for: response.genres)
                    self.number_of_seasons = "\(response.number_of_seasons)"
                    self.overview = response.overview
                    self.getSimilarShows()
                    self.getTrailer()
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
    
    func getSimilarShows() {
        func getShows() {
            var url = SearchModel.APILinks.TVShow.SimilarTVShows
            url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
            url = url.replacingOccurrences(of: "{TVID}", with: "\(id)")
            
            let request = URLRequest(url: URL(string: url)!)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print(error)
                }
                else {
                    let response = try! JSONDecoder().decode(SearchModel.self, from: data!)
                    DispatchQueue.main.async {
                        for show in response.results {
                            listShows(show.id)
                        }
                        
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
                        self.similarShows.append(response)
                    }
                }
            }.resume()
        }
        
        getShows()
        
    }
    
    func getTrailer() {
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
}