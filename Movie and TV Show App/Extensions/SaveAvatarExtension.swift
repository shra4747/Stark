//
//  SaveAvatarExtension.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/15/21.
//

import Foundation
import UIKit

public func setImage(image: UIImage, key: String) {
    UserDefaults.standard.set(image.jpegData(compressionQuality: 100), forKey: key)
}

public func getImage(key: String) -> UIImage? {
    if let imageData = UserDefaults.standard.value(forKey: key) as? Data{
        if let imageFromData = UIImage(data: imageData){
            return imageFromData
        }
    }
    return nil
}
