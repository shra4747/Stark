//
//  RecommendationEngineExtension.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/14/21.
//

import Foundation
import SwiftUI
import UIKit

struct WRatedModel: Codable, Hashable, Identifiable {
    let id: Int
    let stars_rated: Int
}

struct WRatedGeneral: Codable, Hashable {
    let movie: Stars
    let show: Stars
    
    struct Stars: Codable, Hashable {
        let Five: [WRatedModel]
        let Four: [WRatedModel]
        let Three: [WRatedModel]
        let Disliked: [WRatedModel]
    }
}



class RecommendationEngine {
    
    func getMovieRecommendations() -> [WRatedModel] {
        
        let generalModel = getWatchedAndRated()
        
        var WRArr: [WRatedModel] = []
        
        if generalModel.movie.Five.count >= 5 {
            WRArr.append(contentsOf: (generalModel.movie.Five).pickRandom(5))
        }
        else {
            WRArr.append(contentsOf: (generalModel.movie.Five))
        }
        
        if generalModel.movie.Four.count >= 4 {
            WRArr.append(contentsOf: (generalModel.movie.Four).pickRandom(3))
        }
        else {
            WRArr.append(contentsOf: (generalModel.movie.Four))
        }
        
        if generalModel.movie.Three.count >= 3 {
            WRArr.append(contentsOf: (generalModel.movie.Three).pickRandom(2))
        }
        else {
            WRArr.append(contentsOf: (generalModel.movie.Three))
        }
        
        return WRArr
    }
    
    func getShowRecommendations() -> [WRatedModel] {
        
        let generalModel = getWatchedAndRated()
        
        var WRArr: [WRatedModel] = []
        
        if generalModel.show.Five.count >= 5 {
            WRArr.append(contentsOf: (generalModel.show.Five).pickRandom(5))
        }
        else {
            WRArr.append(contentsOf: (generalModel.show.Five))
        }
        
        if generalModel.show.Four.count >= 4 {
            WRArr.append(contentsOf: (generalModel.show.Four).pickRandom(3))
        }
        else {
            WRArr.append(contentsOf: (generalModel.show.Four))
        }
        
        if generalModel.show.Three.count >= 3 {
            WRArr.append(contentsOf: (generalModel.show.Three).pickRandom(2))
        }
        else {
            WRArr.append(contentsOf: (generalModel.show.Three))
        }
        
        return WRArr
    }
    
    func getWatchedAndRated() -> WRatedGeneral {
        
        let Mfive = decode(for: "Mfive")
        let Mfour = decode(for: "Mfour")
        let Mthree = decode(for: "Mthree")
        let Mdislike = decode(for: "Mdislike")
        
        let Tfive = decode(for: "Tfive")
        let Tfour = decode(for: "Tfour")
        let Tthree = decode(for: "Tthree")
        let Tdislike = decode(for: "Tdislike")
        
        let generalModel = WRatedGeneral(movie: WRatedGeneral.Stars(Five: Mfive, Four: Mfour, Three: Mthree, Disliked: Mdislike), show: WRatedGeneral.Stars(Five: Tfive, Four: Tfour, Three: Tthree, Disliked: Tdislike))
        return generalModel
    }
    
    func loadRatingViewState(mediaType: SearchModel.MediaType, id: Int) -> ViewReturn {
        let generalModel = getWatchedAndRated()
        
        let movie = checkInModel(stars: generalModel.movie, id: id)
        if movie.wr {
            return ViewReturn(wr: true, stars: movie.model.stars_rated)
        }
        
        let show = checkInModel(stars: generalModel.show, id: id)
        if show.wr {
            return ViewReturn(wr: true, stars: show.model.stars_rated)
        }
        
        return ViewReturn(wr: false, stars: 0)
    }
    
    struct ViewReturn {
        let wr: Bool
        let stars: Int
    }
    
    struct Returnable {
        let model: WRatedModel
        let wr: Bool
    }
        
    func checkInModel(stars: WRatedGeneral.Stars, id: Int) -> Returnable {
        for content in stars.Five {
            if content.id == id {
                return Returnable(model: content, wr: true)
            }
        }
        
        for content in stars.Four {
            if content.id == id {
                return Returnable(model: content, wr: true)
            }
        }
        
        for content in stars.Three {
            if content.id == id {
                return Returnable(model: content, wr: true)
            }
        }
        
        for content in stars.Disliked {
            if content.id == id {
                return Returnable(model: content, wr: true)
            }
        }
        
        return Returnable(model: WRatedModel(id: 0, stars_rated: 0), wr: false)
        
    }
    
    func WatchAndRated(mediaType: SearchModel.MediaType, model: WRatedModel) {
        
        if mediaType == .movie {
            if model.stars_rated == 5 {
                let five = decode(for: "Mfive")
                encode(for: "Mfive", arr: five, appendModel: model)
            }
            else if model.stars_rated == 4 {
                let four = decode(for: "Mfour")
                encode(for: "Mfour", arr: four, appendModel: model)
            }
            else if model.stars_rated == 3 {
                let three = decode(for: "Mthree")
                encode(for: "Mthree", arr: three, appendModel: model)
            }
            else {
                let dislike = decode(for: "Mdislike")
                encode(for: "Mdislike", arr: dislike, appendModel: model)
            }
        }
        else if mediaType == .show {
            if model.stars_rated == 5 {
                let five = decode(for: "Tfive")
                encode(for: "Tfive", arr: five, appendModel: model)
            }
            else if model.stars_rated == 4 {
                let four = decode(for: "Tfour")
                encode(for: "Tfour", arr: four, appendModel: model)
            }
            else if model.stars_rated == 3 {
                let three = decode(for: "Tthree")
                encode(for: "Tthree", arr: three, appendModel: model)
            }
            else {
                let dislike = decode(for: "Tdislike")
                encode(for: "Tdislike", arr: dislike, appendModel: model)
            }
        }
        
    }
    
    func decode(for strStar: String) -> [WRatedModel] {
        guard let data = UserDefaults.standard.data(forKey: "\(strStar)-star") else {
            return []
        }
        
        if let decoded = try? JSONDecoder().decode([WRatedModel].self, from: data) {
            return decoded
        }
        
        return []
    }
    
    func encode(for strStar: String, arr: [WRatedModel], appendModel: WRatedModel) {
        
        var encodableArr = arr
        encodableArr.append(appendModel)
        
        let encoded = try? JSONEncoder().encode(encodableArr)
        
        UserDefaults.standard.set(encoded, forKey: "\(strStar)-star")
    }
    
    func removeFromAllWR(mediaType: SearchModel.MediaType, model: WRatedModel) {
        let movies = ["Mfive", "Mfour", "Mthree", "Mdislike"]
        let shows = ["Tfive", "Tfour", "Tthree", "Tdislike"]
        
        switch mediaType {
        case .movie:
            for star in movies {
                var decoded = decode(for: star)
                if let index = decoded.firstIndex(of: model) {
                    decoded.remove(at: index)
                    let encoded = try? JSONEncoder().encode(decoded)
                    UserDefaults.standard.set(encoded, forKey: "\(star)-star")
                }
            }
        case .show:
            for star in shows {
                var decoded = decode(for: star)
                if let index = decoded.firstIndex(of: model) {
                    decoded.remove(at: index)
                    let encoded = try? JSONEncoder().encode(decoded)
                    UserDefaults.standard.set(encoded, forKey: "\(star)-star")
                }
            }
        }
    }
}
