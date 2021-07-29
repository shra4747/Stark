//
//  SearchViewModel.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 7/28/21.
//

import Foundation
import SwiftUI

class SearchViewModel: ObservableObject {
    var query = ""
    @Published var results: [Any] = []
    
    func search() {
        var url = SearchModel.APILinks.MultiSearch
        url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
        url = url.replacingOccurrences(of: "{QUERY}", with: query.replacingOccurrences(of: " ", with: "+"))
        let request = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            }
            else {
                let searchResult = try! JSONDecoder().decode(SearchModel.self, from: data!)
                
                for result in searchResult.results {
                    if result.media_type == "tv" {
                        self.getTVShowInfo(result.id)
                    }
                    else if result.media_type == "movie" {
                        self.getMovieInfo(result.id)
                    }
                }
            }
        }.resume()
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
                let response = try! JSONDecoder().decode(SearchModel.Movie.self, from: data!)
                DispatchQueue.main.async {
                    self.results.removeAll()
                    self.results.append(response)
                }
            }
        }.resume()
    }
    
    func getTVShowInfo(_ tvID: Int) {
        var url = SearchModel.APILinks.TVShow.TVShowInfo
        url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
        url = url.replacingOccurrences(of: "{TVID}", with: "\(tvID)")
        let request = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            }
            else {
                let response = try! JSONDecoder().decode(SearchModel.TVShow.self, from: data!)                
                DispatchQueue.main.async {
                    self.results.removeAll()
                    self.results.append(response)
                }
            }
        }.resume()
    }
}
