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
    @Published var selectedType: SearchModel.MediaType = .movie
    @Published var isLoading = false
    @Published var movies: [SearchModel.Movie] = []
    @Published var shows: [SearchModel.TVShow] = []
    
    func search() {
        
        self.movies.removeAll()
        self.shows.removeAll()
        
        var url: String
        
        switch selectedType {
        case .movie:
            url = SearchModel.APILinks.Movie.MovieSearch
        case .show:
            url = SearchModel.APILinks.TVShow.TVShowSearch
        }
        
        url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
        url = url.replacingOccurrences(of: "{QUERY}", with: query.replacingOccurrences(of: " ", with: "+"))
        url = url.replacingOccurrences(of: "’", with: "%27")

        let request = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            }
            else {
                let searchResult = try! JSONDecoder().decode(SearchModel.self, from: data!)
                DispatchQueue.main.async {
                    for result in searchResult.results {
                        switch self.selectedType {
                        case .movie:
                            self.getMovieInfo(result.id)
                        case .show:
                            self.getTVShowInfo(result.id)
                        }
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                    self.isLoading = false
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
                    self.movies.append(response)
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
                    self.shows.append(response)
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
}
