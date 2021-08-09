//
//  ChooseGroupViewModel.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/8/21.
//

import Foundation
import SwiftUI

class ChooseGroupViewModel: ObservableObject {
    @StateObject var groupsModel = BookmarkedViewModel()
    var model = BookmarkModel(id: 0, poster_path: "", title: "", media_type: .movie, release_date: "")
    
    func addMediaToGroup(for groupID: String) {
        guard let data = UserDefaults.standard.data(forKey: "saved-\(groupID)") else {
            // ADD HERE
            let encoded = try? JSONEncoder().encode([model])
            
            UserDefaults.standard.set(encoded, forKey: "saved-\(groupID)")
            return
        }
        
        let group = try? JSONDecoder().decode([BookmarkModel].self, from: data)
        
        var content: [BookmarkModel] = []
        content = group ?? []
        
        content.append(model)
        
        let encoded = try? JSONEncoder().encode(content)
        
        UserDefaults.standard.set(encoded, forKey: "saved-\(groupID)")
    }
}
