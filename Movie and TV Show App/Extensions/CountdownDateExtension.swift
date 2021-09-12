//
//  CountdownDateExtension.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/16/21.
//

import Foundation
import UIKit
import SwiftUI

class CountdownDate {
    func returnIfCountdown(dateString: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if dateString == "" {
            return false
        }
        let date = dateFormatter.date(from: dateString)!
        let today = Calendar.current.startOfDay(for: Date())
        let daysUntil = ((Calendar.current.dateComponents([.day], from: today, to: date).day ?? 0))
        if daysUntil > 0 {
            return true
        }
        else {
            return false
        }
    }
    
    func returnDaysUntil(dateString: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: dateString) {
            let today = Calendar.current.startOfDay(for: Date())
            return ((Calendar.current.dateComponents([.day], from: today, to: date).day ?? 0))
        }
        else {
            return 0
        }
    }
    
    func findReleaseDate(movieID: Int, completion: @escaping (String) -> Void) {
        var url = SearchModel.APILinks.Movie.ReleaseDate
        url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
        url = url.replacingOccurrences(of: "{MOVIEID}", with: "\(movieID)")
        
        let request = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            }
            else {
                let response = try! JSONDecoder().decode(ReleaseDates.self, from: data!)
                for result in response.results {
                    if result.iso_3166_1 == "US" {
                        
                        for date in result.release_dates {
                            if date.type != 1 {
                                completion(date.release_date.stringBefore("T"))
                                return
                            }
                        }
                    }
                }

            }
        }.resume()
    }
    
    func findLatestSeasonReleaseDate(showID: Int, completion: @escaping (String) -> Void) {
        var url = SearchModel.APILinks.TVShow.TVShowInfo
        url = url.replacingOccurrences(of: "{APIKEY}", with: "9ca74361766772691be0f40f58010ee4")
        url = url.replacingOccurrences(of: "{TVID}", with: "\(showID)")
        
        let request = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error)
            }
            else {
                let response = try! JSONDecoder().decode(TVReleaseDates.self, from: data!)
                if response.seasons.count > 0 {
                    let latestSeason = response.seasons.last!
                    if latestSeason.season_number != 0 {
                        if let date = latestSeason.air_date {
                            
                            completion(date)
                            return
                        }
                        
                    }
                    
                }
                
                completion("")
                return
            }
        }.resume()
    }
    
    struct TVReleaseDates: Codable, Hashable {
        let seasons: [Season]
        
        struct Season: Codable, Hashable {
            let air_date: String?
            let season_number: Int
        }
    }
    
    
    struct ReleaseDates: Codable, Hashable {
        let id: Int
        let results: [Result]
        
        struct Result: Codable, Hashable {
            let iso_3166_1: String
            let release_dates: [RDate]
            
            struct RDate: Codable, Hashable {
                let release_date: String
                let type: Int
            }
        }
    }
}

extension String {
    func stringBefore(_ delimiter: Character) -> String {
        if let index = firstIndex(of: delimiter) {
            return String(prefix(upTo: index))
        } else {
            return ""
        }
    }
    
    func stringAfter(_ delimiter: Character) -> String {
        if let index = firstIndex(of: delimiter) {
            return String(suffix(from: index).dropFirst())
        } else {
            return ""
        }
    }
}

extension Date {
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
}


