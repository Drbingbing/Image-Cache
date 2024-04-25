//
//  ServerConfig.swift
//  University_Assignment
//
//  Created by Bing Bing on 2024/4/19.
//

import Foundation

protocol ServerConfig {
    var apiBaseURL: URL { get }
}

struct ServerConfigImpl: ServerConfig {
    
    let apiBaseURL: URL
    
    static var development: ServerConfig = ServerConfigImpl(
        apiBaseURL: URL(string: "https://raw.githubusercontent.com")!
    )
}
