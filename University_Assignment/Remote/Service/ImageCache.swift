//
//  ImageCache.swift
//  University_Assignment
//
//  Created by Bing Bing on 2024/4/20.
//

import Foundation
import CoreImage

func initializeImageCache() -> ImageCache {
    let config = URLSessionConfiguration.ephemeral
    return ImageCacheImpl(session: URLSession(configuration: config))
}

protocol ImageCache {
    func load(url: String, completion: @escaping (CIImage?) -> Void)
}

final class ImageCacheImpl: ImageCache {
        
    private let session: URLSession
    private let cachedImages = NSCache<NSURL, CIImage>()
    private var loadingResponses = [NSURL: [(CIImage?) -> Void]]()

    init(session: URLSession) {
        self.session = session
    }
    
    func image(url: NSURL) -> CIImage? {
        return cachedImages.object(forKey: url)
    }
    
    func load(url: String, completion: @escaping (CIImage?) -> Void) {
        guard let URL = NSURL(string: url) else { return }
        if let cachedImage = image(url: URL) {
            DispatchQueue.main.async {
                completion(cachedImage)
            }
            return
        }
        
        if loadingResponses[URL] != nil {
            loadingResponses[URL]?.append(completion)
            return
        } else {
            loadingResponses[URL] = [completion]
        }
        
        session.dataTask(with: URL as URL) { data, response, error in
            guard let responseData = data, let image = CIImage(data: responseData),
                let blocks = self.loadingResponses[URL], error == nil else {
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            
            self.cachedImages.setObject(image, forKey: URL, cost: responseData.count)
            
            for block in blocks {
                DispatchQueue.main.async {
                    block(image)
                }
            }
        }.resume()
    }
}
