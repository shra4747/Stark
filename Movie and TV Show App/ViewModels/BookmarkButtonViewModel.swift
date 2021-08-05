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
    var release_Date = ""
    @Published var hasBeenSaved = false
    
    func changeStateOnAppear() {
        guard let data = UserDefaults.standard.data(forKey: "saved-001") else {
            self.hasBeenSaved = false
            return
        }

        let watchLater = try? JSONDecoder().decode([BookmarkModel].self, from: data)
                
        
        if let watchLater = watchLater {
            for media in watchLater {
                if media.id == id {
                    self.hasBeenSaved = true
                    return
                }
            }
        }
    }
    
    func buttonClick() {
        guard let data = UserDefaults.standard.data(forKey: "saved-001") else {
            self.hasBeenSaved = true
            
            let bookmarks = [BookmarkModel(id: id, poster_path: poster_path, title: title, media_type: media_type, release_date: release_Date)]
            
            let data = try? JSONEncoder().encode(bookmarks)
            UserDefaults.standard.set(data, forKey: "saved-001")
            return
        }

        let watchLater = try? JSONDecoder().decode([BookmarkModel].self, from: data)
        

        if let watchLater = watchLater {
            
            for media in watchLater {
                if media.id == id {
                    self.hasBeenSaved = false
                    let index = watchLater.firstIndex(of: BookmarkModel(id: id, poster_path: poster_path, title: title, media_type: media_type, release_date: release_Date))
                    var new = watchLater
                    if let index = index {
                        new.remove(at: index)
                    }
                    
                    let newData = try? JSONEncoder().encode(new)

                    UserDefaults.standard.set(newData, forKey: "saved-001")
                    return
                }
            }
            
            self.hasBeenSaved = true
            
            var new = watchLater
            new.append(BookmarkModel(id: id, poster_path: poster_path, title: title, media_type: media_type, release_date: release_Date))

            let newData = try? JSONEncoder().encode(new)

            UserDefaults.standard.set(newData, forKey: "saved-001")
            return
        }
    }
}
