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
        guard let savedGroupsData = UserDefaults.standard.data(forKey: "groups") else {
            return
        }
        
        let decoded = try? JSONDecoder().decode([BookmarkGroupModel].self, from: savedGroupsData)
        
        if let savedGroups = decoded {
            self.groups = savedGroups
        }
        
    }
}
