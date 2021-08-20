//
//  LoadImageExtension.swift
//  
//
//  Created by Shravan Prasanth on 7/31/21.
//

import Foundation
import UIKit

extension String {
    func loadImage(type: EmptyImageType, colorScheme: DarkLightType) -> UIImage {
        
        do {
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(self)") else {
                return UIImage()
            }
            
            let data: Data = try Data(contentsOf: url)
            
            switch type {
            case .cast:
                return UIImage(data: data) ?? UIImage(named: "Cast\(colorScheme == .light ? "Light" : "Dark")")!
            case .episodes:
                return UIImage(data: data) ?? UIImage(named: "Episodes\(colorScheme == .light ? "Light" : "Dark")")!
            case .search:
                return UIImage(data: data) ?? UIImage(named: "Search\(colorScheme == .light ? "Light" : "Dark")")!

            case .similar:
                return UIImage(data: data) ?? UIImage(named: "Similar\(colorScheme == .light ? "Light" : "Dark")")!
            }
        } catch {
            
        }
        
        return UIImage()
    }
}

func getDefaultImage(type: EmptyImageType, colorScheme: DarkLightType) -> UIImage {
    switch type {
    case .cast:
        return UIImage(named: "Cast\(colorScheme == .light ? "Light" : "Dark")")!
    case .episodes:
        return UIImage(named: "Episodes\(colorScheme == .light ? "Light" : "Dark")")!
    case .search:
        return UIImage(named: "Search\(colorScheme == .light ? "Light" : "Dark")")!

    case .similar:
        return UIImage(named: "Similar\(colorScheme == .light ? "Light" : "Dark")")!
    }
}

enum EmptyImageType {
    case cast, episodes, search, similar
}
enum DarkLightType {
    case dark, light
}
