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
    @Published var hasBeenSaved = false
    
    func changeStateOnAppear() {
        guard let savedMovies = UserDefaults.standard.value(forKey: "TESTsm") else {
            self.hasBeenSaved = false
            return
        }
        
        if let savedMovies = savedMovies as? [Int] {
            if savedMovies.contains(id) {
                self.hasBeenSaved = true
            }
        }
    }
    
    func buttonClick() {
        guard let savedMovies = UserDefaults.standard.value(forKey: "TESTsm") else {
            self.hasBeenSaved = true
            UserDefaults.standard.set([id], forKey: "TESTsm")
            print([id], "has not been saved")
            return
        }
        print(savedMovies)
        if let savedMovies = savedMovies as? [Int] {
            if savedMovies.contains(id) {
                self.hasBeenSaved = false
                let index = savedMovies.firstIndex(of: id)
                var new = savedMovies
                if let index = index {
                    new.remove(at: index)
                }
                print(new, "has been saved")
                UserDefaults.standard.set(new, forKey: "TESTsm")
            }
            else if !savedMovies.contains(id) {
                self.hasBeenSaved = true
                
                var new = savedMovies
                new.append(id)
                print(new, "has not been saved")
                UserDefaults.standard.set(new, forKey: "TESTsm")
            }
            
        }
    }
}
