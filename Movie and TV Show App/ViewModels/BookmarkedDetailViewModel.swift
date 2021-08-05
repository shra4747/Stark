//
//  BookmarkedDetailViewModel.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/3/21.
//

import SwiftUI

class BookmarkedDetailViewModel: ObservableObject {
    @Published var bookmarkedContent: [BookmarkModel] = []
    
    var groupID: Int = 0
    
    func load() {
        guard let data = UserDefaults.standard.data(forKey: "saved-001") else {
            return
        }

        let watchLater = try? JSONDecoder().decode([BookmarkModel].self, from: data)
        
        bookmarkedContent = watchLater ?? []

    }
}
