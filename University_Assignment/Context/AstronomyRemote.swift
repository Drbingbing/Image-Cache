//
//  AstronomyRemote.swift
//  University_Assignment
//
//  Created by Bing Bing on 2024/4/19.
//

import Foundation

extension AstronomyContext {
    
    final class Remote {
        
        private let network: Network
        
        init(network: Network) {
            self.network = network
        }
        
        func fetchAll(completion: @escaping ([Astronomy]) -> Void) {
            _internal_fetchAllAstronomy(network: network, completion: completion)
        }
    }
}

private func _internal_fetchAllAstronomy(network: Network, completion: @escaping ([Astronomy]) -> Void) {
    network.request(Api.functions.Astronomy.allAstronomy()) { result in
        completion(result ?? [])
    }
}
