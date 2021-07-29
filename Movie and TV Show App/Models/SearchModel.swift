//
//  SearchModel.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 7/28/21.
//

import Foundation

struct SearchModel: Codable {
    let page: Int
    let results: [Result]
    let total_results: Int
    let total_pages: Int
    
    struct Result: Codable {
        let media_type: String
        let id: Int
    }
}

extension SearchModel {
    struct Movie: Codable {
        let backdrop_path: String?
        let genres: [Genre]
        let id: Int
        let overview: String
        let poster_path: String?
        let release_date: String
        let runtime: Int
        let status: String
        let title: String
    }
    
    struct TVShow: Codable {
        let backdrop_path: String
        let genres: [Genre]
        let id: Int
        let name: String
        let number_of_episodes: Int
        let number_of_seasons: Int
        let overview: String
        let poster_path: String
        let status: String
    }
    
    struct Genre: Codable {
        let id: Int
        let name: String
    }
    
    struct Video: Codable {
        let results: [VideoInfo]
        
        struct VideoInfo: Codable {
            let name: String
            let key: String
            let site: String
            let type: String
            let official: String
            let id: String
        }
    }
    
    struct Credits: Codable {
        let cast: [Cast]
        
        struct Cast: Codable {
            let id: Int
            let known_for_department: String
            let name: String
            let profile_path: String
            let cast_id: String
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
        static let MultiSearch = "https://api.themoviedb.org/3/search/multi?api_key={APIKEY}&query={QUERY}&page=1"
        
        class Movie {
            static let MovieInfo = "https://api.themoviedb.org/3/movie/{MOVIEID}?api_key={APIKEY}"
            
            static let MovieCredits = "https://api.themoviedb.org/3/movie/{MOVIEID}/credits?api_key={APIKEY}"
            
            static let SimilarMovies = "https://api.themoviedb.org/3/movie/{MOVIEID}/similar?api_key={APIKEY}&page=1"
            
            static let MovieVideos = "https://api.themoviedb.org/3/movie/{MOVIEID}/videos?api_key={APIKEY}"
        }
        
        class TVShow {
            static let TVShowInfo = "https://api.themoviedb.org/3/tv/{TVID}?api_key={APIKEY}"
            
            static let TVShowCredits = "https://api.themoviedb.org/3/tv/{TVID}/season/{SEASONID}/credits?api_key={APIKEY}"
            
            static let SimilarTVShows = "https://api.themoviedb.org/3/tv/{TVID}/similar?api_key={APIKEY}&page=1"
            
            static let TVShowVideos = "https://api.themoviedb.org/3/tv/{TVID}/videos?api_key={APIKEY}"
        }
    }
}

