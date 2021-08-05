//
//  BookmarkedViewModel.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/1/21.
//

import Foundation
import SwiftUI

class BookmarkedViewModel: ObservableObject {
    @Published var groups: [BookmarkGroupModel] = []

    func load() {
        guard let savedGroups = UserDefaults.standard.value(forKey: "groups") as? [BookmarkGroupModel] else {
            UserDefaults.standard.set(BookmarkModelDefaultGroups.defaultGroups, forKey: "groups")
            self.load()
            return
        }
        
        self.groups = savedGroups
    }
}
