//
//  BookmarkModel.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/3/21.
//

import Foundation

struct BookmarkModel: Codable, Hashable {
    let id: Int
    let poster_path: String
    let title: String
    let media_type: SearchModel.MediaType
    let release_date: String
}

struct BookmarkGroupModel: Codable, Hashable {
    let name: String
    let id: Int
}

class BookmarkModelDefaultGroups {
    static let watchLater = BookmarkGroupModel(name: "Watch Later", id: 001)
    
    static let countdown = BookmarkGroupModel(name: "Countdown", id: 002)
    
    static let defaultGroups = [watchLater, countdown]
}
