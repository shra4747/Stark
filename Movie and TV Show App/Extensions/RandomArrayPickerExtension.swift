//
//  RandomArrayPickerExtension.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 8/14/21.
//

import Foundation

extension Array where Element: Hashable {
    func pickRandom(_ n: Int) -> [Element] {
        let set: Set<Element> = Set(self)
        guard set.count >= n else {
            fatalError("The array has to have at least \(n) unique values")
        }
        guard n >= 0 else {
            fatalError("The number of elements to be picked must be positive")
        }

        return Array(set.prefix(upTo: set.index(set.startIndex, offsetBy: n)))
    }
}
extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
