//
//  AstronomyImage.swift
//  University_Assignment
//
//  Created by Bing Bing on 2024/4/20.
//

import Foundation
import UIKit

extension AstronomyContext {
    
    final class Image {
        private let cache: ImageCache
        
        init(cache: ImageCache) {
            self.cache = cache
        }
        
        func setImageURL(_ url: String, completion: @escaping (UIImage?) -> Void) {
            _internal_setImageWithURL(cache: cache, url: url, completion: completion)
        }
    }
}

private func _internal_setImageWithURL(cache: ImageCache, url: String, completion: @escaping (UIImage?) -> Void) {
    cache.load(url: url) {
        if let image = $0 {
            completion(UIImage(ciImage: image))
        } else {
            completion(nil)
        }
    }
}
