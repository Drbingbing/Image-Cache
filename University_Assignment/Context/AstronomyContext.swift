//
//  AstronomyContext.swift
//  University_Assignment
//
//  Created by Bing Bing on 2024/4/19.
//

import Foundation

final class AstronomyContext {
    
    private let context: Context
    
    lazy var remote: Remote = {
        return Remote(network: context.network)
    }()
    
    lazy var image: Image = {
        return Image(cache: context.imageCache)
    }()
    
    init(argument: NetworkInitializationArguements) {
        context = Context(network: initializeNetwork(arguements: argument), imageCache: initializeImageCache())
    }
}

private class Context {
    
    let network: Network
    let imageCache: ImageCache
    
    init(network: Network, imageCache: ImageCache) {
        self.network = network
        self.imageCache = imageCache
    }
}
