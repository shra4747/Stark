//
//  LoadImageExtension.swift
//  
//
//  Created by Shravan Prasanth on 7/31/21.
//

import Foundation
import UIKit

extension String {
    func loadImage() -> UIImage {
        
        do {
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(self)") else {
                return UIImage()
            }
            
            let data: Data = try Data(contentsOf: url)
            
            return UIImage(data: data) ?? UIImage(imageLiteralResourceName: "questionmark")
        } catch {
            
        }
        
        return UIImage()
    }
}
