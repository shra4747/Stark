//
//  WidgetModel.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/16/21.
//

import Foundation
import SwiftUI

struct WidgetModel: Codable, Hashable, Identifiable {
    let title: String
    let release_date: String
    let poster_path: String
    var id: String { title }
}
