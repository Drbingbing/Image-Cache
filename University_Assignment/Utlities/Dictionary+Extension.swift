//
//  Dictionary+Extension.swift
//  University_Assignment
//
//  Created by Bing Bing on 2024/4/19.
//

import Foundation

extension Dictionary {
    func withAllValuesFrom(_ other: Dictionary) -> Dictionary {
        var result = self
        other.forEach { result[$0] = $1 }
        return result
    }
}
