//
//  AddNewGroupViewModel.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/5/21.
//

import Foundation
import SwiftUI

class AddNewGroupViewModel: ObservableObject {
    var colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]
    @Published var gradient: [Color] = []
    @Published var icon = ""
    @Published var groupName = ""
    
    @Published var isShowingError = false
    @Published var errorName = ""
    @Published var errorDescription = ""
    
    
    init() {
        shuffleGradient()
    }
    
    func shuffleGradient() {
        let color1 = colors.randomElement()!
        var color2 = colors.randomElement()!
        while color2 == color1 {
            color2 = colors.randomElement()!
        }
        gradient = [color1, color2]
    }
    
    func addButtonClicked() {
        
        // Check if all fields are inputted
        if self.icon == "" || self.groupName == "" {
            // Show Alert
        }
        
        // Create Model struct
        let id = UUID().uuidString
        let newGroupModel  = BookmarkGroupModel(name: self.groupName, icon: self.icon, gradient: self.gradient, id: id)
        
        // Get saved Groups array
        guard let savedGroupsData = UserDefaults.standard.data(forKey: "groups") else {
            // No Saved
            let encoded = try? JSONEncoder().encode([newGroupModel])
            
            // Save array to 'groups' user defaults
            UserDefaults.standard.set(encoded, forKey: "groups")
            return
        }
        
        let decoded = try? JSONDecoder().decode([BookmarkGroupModel].self, from: savedGroupsData)
        
        if let savedGroups = decoded {
            // Append Model to saved groups array
            var mutableGroups = savedGroups
            mutableGroups.append(newGroupModel)
            
            // Encode new array
            
            let encoded = try? JSONEncoder().encode(mutableGroups)
            
            // Save array to 'groups' user defaults
            UserDefaults.standard.set(encoded, forKey: "groups")
            
        }
        else {
            return
        }
        
        
    }
}
