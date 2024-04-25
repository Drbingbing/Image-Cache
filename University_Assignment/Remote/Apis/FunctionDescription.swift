//
//  FunctionDescription.swift
//  University_Assignment
//
//  Created by Bing Bing on 2024/4/19.
//

import Foundation

struct FunctionDescription {
    let path: String
    let parameters: [String: Any]
    
    init(path: String, parameters: [String : Any]) {
        self.path = path
        self.parameters = parameters
    }
}


struct DeserializeFunctionResponse<T> {
    private let f: (Data?) -> T?
    
    init(f: @escaping (Data?) -> T?) {
        self.f = f
    }
    
    func parse(_ d: Data?) -> T? {
        f(d)
    }
}
