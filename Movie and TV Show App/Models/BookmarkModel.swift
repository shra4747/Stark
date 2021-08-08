//
//  BookmarkModel.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/3/21.
//

import Foundation
import SwiftUI

struct BookmarkModel: Codable, Hashable {
    let id: Int
    let poster_path: String
    let title: String
    let media_type: SearchModel.MediaType
    let release_date: String
}

struct BookmarkGroupModel: Codable, Hashable {
    let name: String
    let icon: String
    let gradient: [Color]
    let id: String
}

class BookmarkModelDefaultGroups {
    static let watchLater = BookmarkGroupModel(name: "Watch Later", icon: "clock.arrow.2.circlepath", gradient: [.blue, .purple], id: "001")
    
    static let countdown = BookmarkGroupModel(name: "Countdown", icon: "clock", gradient: [.red, .orange], id: "002")
    
    static let defaultGroups = [watchLater, countdown]
}
