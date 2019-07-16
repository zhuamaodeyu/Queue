//
//  Dictionary+Exts.swift
//  Queen
//
//  Created by 聂子 on 2019/7/16.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation
extension Dictionary {

    /// Return a new dictionary containing the keys transformed by the given closure with the values of this dictionary.
    ///
    /// - Parameter transform: A closure that transforms a key. Every transformed key must be unique.
    /// - Returns: A dictionary containing transformed keys and the values of this dictionary.
    func mapKeys<T>(transform: (Key) throws -> T) rethrows -> [T: Value] {

        let keysWithValues = try self.map { (key, value) -> (T, Value) in
            (try transform(key), value)
        }

        return [T: Value](uniqueKeysWithValues: keysWithValues)
    }

}
