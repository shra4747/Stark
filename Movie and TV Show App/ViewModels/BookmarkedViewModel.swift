//
//  BookmarkedViewModel.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/1/21.
//

import Foundation
import SwiftUI

class BookmarkedViewModel: ObservableObject {
    @Published var TESTsms: [Int] = []
    
    func load() {
        guard let savedMovies = UserDefaults.standard.value(forKey: "TESTsm") as? [Int] else {
            return
        }
        
        self.TESTsms = savedMovies
    }
}
