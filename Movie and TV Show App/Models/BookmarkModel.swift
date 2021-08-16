//
//  BookmarkModel.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/3/21.
//

import Foundation
import SwiftUI

struct BookmarkModel: Codable, Hashable, Comparable {
    
    
    let id: Int
    let poster_path: String
    let title: String
    let media_type: SearchModel.MediaType
    let release_date: String
    
    static func < (lhs: BookmarkModel, rhs: BookmarkModel) -> Bool {
        CountdownDate().returnDaysUntil(dateString: lhs.release_date) < CountdownDate().returnDaysUntil(dateString: rhs.release_date)
    }
}

struct BookmarkGroupModel: Codable, Hashable {
    let name: String
    let icon: String
    let gradient: [Color]
    let id: String
}

class BookmarkModelDefaultGroups {
    static let watchLater = BookmarkGroupModel(name: "Watch Later", icon: "📺", gradient: [.blue, .purple], id: "001")
    
    static let countdown = BookmarkGroupModel(name: "Countdown", icon: "🕥", gradient: [.red, .orange], id: "002")
    
    static let defaultGroups = [watchLater, countdown]
}
