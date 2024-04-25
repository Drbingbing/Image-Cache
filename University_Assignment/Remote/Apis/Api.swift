//
//  Api.swift
//  University_Assignment
//
//  Created by Bing Bing on 2024/4/19.
//

import Foundation

enum Api {
    enum functions {
        enum Astronomy {}
    }
}

extension Api {
    
    static func parse<T: Decodable>(json j: Data) -> T? {
        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: j)
    }
}
