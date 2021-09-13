//
//  BookmarkButtonViewModel.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/1/21.
//

import Foundation
import SwiftUI

class BookmarkButtonViewModel: ObservableObject {
    
    var id = 0
    var poster_path = ""
    var title = ""
    var media_type: SearchModel.MediaType = .movie
    @Published var release_Date = ""
    @Published var hasBeenSaved = false
    @Published var showChooseGroupView = false
    @Published var groupSavedIn = ""
    
    func changeStateOnAppear() {
        checkGroupForId(groupID: "001")
        checkGroupForId(groupID: "002")

        guard let savedGroupsData = UserDefaults.standard.data(forKey: "groups") else {
            if !hasBeenSaved {
                DispatchQueue.main.async {
                    self.hasBeenSaved = false
                }
            }
            return
        }

        let decoded = try? JSONDecoder().decode([BookmarkGroupModel].self, from: savedGroupsData)

        if let savedGroups = decoded {
            for group in savedGroups {
                checkGroupForId(groupID: group.id)
            }
        }
    }
    
    func checkGroupForId(groupID: String) {
        if hasBeenSaved {
            return
        }
        
        guard let data = UserDefaults.standard.data(forKey: "saved-\(groupID)") else {
            self.hasBeenSaved = false
            return
        }

        let content = try? JSONDecoder().decode([BookmarkModel].self, from: data)
                
        
        if let content = content {
            for media in content {
                if media.id == id {
                    DispatchQueue.main.async {
                        self.groupSavedIn = "\(groupID)"
                        self.hasBeenSaved = true
                    }
                    
                }
            }
        }
    }
    
    func buttonClick() {
        
        self.showChooseGroupView.toggle()

    }
}
