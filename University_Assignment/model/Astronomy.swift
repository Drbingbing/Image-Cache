//
//  Astronomy.swift
//  University_Assignment
//
//  Created by Bing Bing on 2024/4/19.
//

import Foundation

struct Astronomy: Decodable {
    
    var title: String
    var description: String
    var copyright: String
    var url: String
    var apodSite: String
    var date: String
    var mediaType: String
    var hdurl: String
    
    private enum CodingKeys: String, CodingKey {
        case description, title, copyright, url, date, hdurl
        case apodSite = "apod_site"
        case mediaType = "media_type"
    }
    
}
