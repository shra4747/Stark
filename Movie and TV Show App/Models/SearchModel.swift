//
//  SearchModel.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 7/28/21.
//

import Foundation

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
    struct Movie: Codable, Hashable {
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
        let poster_path: String
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
            let cast_id: Int
            let character: String
            let order: Int
        }
    }
    
//    struct WatchProviders {
//        let results: [Provider]
//
//        struct Provider {
//
//        }
//    }
}

extension SearchModel {
    class APILinks {
        class Movie {
            static let MovieSearch = "https://api.themoviedb.org/3/search/movie?api_key={APIKEY}&query={QUERY}&page=1"

            static let MovieInfo = "https://api.themoviedb.org/3/movie/{MOVIEID}?api_key={APIKEY}"
            
            static let MovieCredits = "https://api.themoviedb.org/3/movie/{MOVIEID}/credits?api_key={APIKEY}"
            
            static let SimilarMovies = "https://api.themoviedb.org/3/movie/{MOVIEID}/similar?api_key={APIKEY}&page=1"
            
            static let MovieVideos = "https://api.themoviedb.org/3/movie/{MOVIEID}/videos?api_key={APIKEY}"
        }
        
        class TVShow {
            static let TVShowSearch = "https://api.themoviedb.org/3/search/tv?api_key={APIKEY}&page=1&query={QUERY}"

            static let TVShowInfo = "https://api.themoviedb.org/3/tv/{TVID}?api_key={APIKEY}"
            
            static let TVShowCredits = "https://api.themoviedb.org/3/tv/{TVID}/season/{SEASONID}/credits?api_key={APIKEY}"
            
            static let SimilarTVShows = "https://api.themoviedb.org/3/tv/{TVID}/similar?api_key={APIKEY}&page=1"
            
            static let TVShowVideos = "https://api.themoviedb.org/3/tv/{TVID}/videos?api_key={APIKEY}"
        }
    }
    
    enum MediaType {
        case movie, show
    }
}

