//
//  BookmarkedDetailViewModel.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/3/21.
//

import SwiftUI

class BookmarkedDetailViewModel: ObservableObject {
    @Published var bookmarkedContent: [BookmarkModel] = []
    
    var groupID: String = "001"
    
    func load() {
        guard let data = UserDefaults.standard.data(forKey: "saved-\(groupID)") else {
            return
        }

        let watchLater = try? JSONDecoder().decode([BookmarkModel].self, from: data)
        
        bookmarkedContent = watchLater ?? []

    }
    
    func deleteGroup(group: BookmarkGroupModel) {
        guard let savedGroupsData = UserDefaults.standard.data(forKey: "groups") else {
            return
        }
        
        let decoded = try? JSONDecoder().decode([BookmarkGroupModel].self, from: savedGroupsData)
        
        if var savedGroups = decoded {
            if let index = savedGroups.firstIndex(of: group) {
                savedGroups.remove(at: index)
                let encoded = try? JSONEncoder().encode(savedGroups)
                
                // Save array to 'groups' user defaults
                UserDefaults.standard.set(encoded, forKey: "groups")
            }
        }
        
        UserDefaults.standard.set(nil, forKey: "saved\(group.id)")
    }
}
