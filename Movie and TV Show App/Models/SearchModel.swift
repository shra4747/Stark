//
//  SearchModel.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 7/28/21.
//

import Foundation
import UIKit


struct SearchModel: Codable, Hashable {
    let page: Int
    let results: [Result]
    let total_results: Int
    let total_pages: Int
    
    struct Result: Codable, Hashable {
        let id: Int
    }
}

extension SearchModel {
    struct Movie: Codable, Hashable, Identifiable {
        let backdrop_path: String?
        let genres: [Genre]
        let id: Int
        let overview: String
        let poster_path: String?
        let release_date: String
        let runtime: Int?
        let status: String
        let title: String
    }
    
    struct TVShow: Codable, Hashable {
        let backdrop_path: String?
        let genres: [Genre]
        let id: Int
        let name: String
        let number_of_episodes: Int
        let number_of_seasons: Int
        let overview: String
        let poster_path: String?
        let status: String
    }
    
    struct Genre: Codable, Hashable {
        let id: Int
        let name: String
    }
    
    struct Video: Codable, Hashable {
        let results: [VideoInfo]
        
        struct VideoInfo: Codable, Hashable {
            let name: String
            let key: String
            let site: String
            let type: String
            let official: Bool
            let id: String
        }
    }
    
    struct Credits: Codable, Hashable {
        let cast: [Cast]
        
        struct Cast: Codable, Hashable {
            let id: Int
            let known_for_department: String
            let name: String
            let profile_path: String?
            let character: String
            let order: Int
        }
    }
    
    struct WatchProviders: Codable, Hashable {
        let id: Int
        let results: [String: Options]

        struct Options: Codable, Hashable {
            let buy: [Provider]?
            let rent: [Provider]?
            let flatrate: [Provider]?
        }
        
        struct Provider: Codable, Hashable {
            let logo_path: String
            let provider_name: String
        }
    }
}

extension SearchModel {
    class APILinks {
        class Movie {
            static let MovieSearch = "https://api.themoviedb.org/3/search/movie?api_key={APIKEY}&query={QUERY}&page=1"

            static let MovieInfo = "https://api.themoviedb.org/3/movie/{MOVIEID}?api_key={APIKEY}"
            
            static let MovieCredits = "https://api.themoviedb.org/3/movie/{MOVIEID}/credits?api_key={APIKEY}"
            
            static let SimilarMovies = "https://api.themoviedb.org/3/movie/{MOVIEID}/similar?api_key={APIKEY}&page=1"
            
            static let MovieVideos = "https://api.themoviedb.org/3/movie/{MOVIEID}/videos?api_key={APIKEY}"
            
            static let MovieWatchProviders = "https://api.themoviedb.org/3/movie/{MOVIEID}/watch/providers?api_key={APIKEY}"
        }
        
        class TVShow {
            static let TVShowSearch = "https://api.themoviedb.org/3/search/tv?api_key={APIKEY}&page=1&query={QUERY}"

            static let TVShowInfo = "https://api.themoviedb.org/3/tv/{TVID}?api_key={APIKEY}"
            
            static let TVShowCredits = "https://api.themoviedb.org/3/tv/{TVID}/season/1/credits?api_key={APIKEY}"
            
            static let SimilarTVShows = "https://api.themoviedb.org/3/tv/{TVID}/similar?api_key={APIKEY}&page=1"
            
            static let TVShowVideos = "https://api.themoviedb.org/3/tv/{TVID}/videos?api_key={APIKEY}"
            
            static let TVShowWatchProviders = "https://api.themoviedb.org/3/tv/{TVID}/watch/providers?api_key={APIKEY}"
            
            static let TVShowEpisodesInSeason = "https://api.themoviedb.org/3/tv/{TVID}/season/{SEASONID}?api_key={APIKEY}"
        }
    }
    
    enum MediaType: String, Identifiable, CaseIterable, Codable {
        case movie, show
        
        var displayName: String { rawValue.capitalized }
        
        var id: String { self.rawValue }
    }
}

extension SearchModel {
    struct EmptyModel {
        static let Movie = SearchModel.Movie(backdrop_path: "", genres: [], id: 0, overview: "", poster_path: "", release_date: "", runtime: 0, status: "", title: "")
        static let TVShow = SearchModel.TVShow(backdrop_path: "", genres: [], id: 0, name: "", number_of_episodes: 0, number_of_seasons: 0, overview: "", poster_path: "", status: "")
        
        static let Image = ("https://static.vecteezy.com/system/resources/thumbnails/000/365/820/small/Basic_Elements__2818_29.jpg".loadEmptyImage())
    }
}

extension SearchModel.TVShow {
    struct Season: Codable, Hashable {
        let air_date: String
        let name: String
        let overview: String
        let poster_path: String
        let season_number: Int
        let episodes: [Episode]
        
        struct Episode: Codable, Hashable {
            let air_date: String
            let episode_number: Int
            let name: String
            let overview: String
            let still_path: String?
        }
    }
}
