//
//  Network.swift
//  University_Assignment
//
//  Created by Bing Bing on 2024/4/19.
//

import Foundation

struct NetworkInitializationArguements {
    let config: ServerConfig
}

func initializeNetwork(arguements: NetworkInitializationArguements) -> Network {
    let environment = ApiEnvironment(config: arguements.config)
    return Network(apiEnvironment: environment)
}

final class Network {
    
    let apiEnvironment: ApiEnvironment
    let session: URLSession
    
    init(apiEnvironment: ApiEnvironment, session: URLSession? = nil) {
        self.apiEnvironment = apiEnvironment
        self.session = session ?? URLSession(configuration: .default)
    }
    
    func request<T>(_ data: (FunctionDescription, DeserializeFunctionResponse<T>), completion: @escaping (T?) -> Void) {
        guard let URL = URL(string: data.0.path, relativeTo: apiEnvironment.config.apiBaseURL) else {
            fatalError(
                "URL(string: \(data.0.path), relativeToURL: \(apiEnvironment.config.apiBaseURL)) == nil"
            )
        }
        
        let request = prepareRequest(forURL: URL, method: "GET", query: data.0.parameters)
        
        let task = session.dataTask(with: request) { result, response, error in
            let object = data.1.parse(result)
            DispatchQueue.main.async {
                completion(object)
            }
        }
        
        task.resume()
    }
}

private extension Network {
    
    func prepareRequest(forURL url: URL, method: String, query: [String: Any]) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.url = url
        return request
    }
    
    func prepareRequest(forRequest originalRequest: URLRequest, query: [String: Any]) -> URLRequest {
        var request = originalRequest
        guard let URL = request.url else {
            return originalRequest
        }
        
        var headers: [String: String] = [:]
        
        let method = request.httpMethod?.uppercased()
        var components = URLComponents(url: URL, resolvingAgainstBaseURL: false)!
        var queryItems = components.queryItems ?? []
        
        if method == .some("POST") || method == .some("PUT") {
            if request.httpBody == nil {
                headers["Content-Type"] = "application/json; charset=utf-8"
                request.httpBody = try? JSONSerialization.data(withJSONObject: query, options: [])
            }
        } else {
            queryItems.append(
                contentsOf: query
                    .flatMap(queryComponents)
                    .map(URLQueryItem.init(name:value:))
            )
        }
        
        components.queryItems = queryItems.sorted { $0.name < $1.name }
        request.url = components.url
        
        let currentHeaders = request.allHTTPHeaderFields ?? [:]
        request.allHTTPHeaderFields = currentHeaders.withAllValuesFrom(headers)
        
        return request
    }
    
    private func queryComponents(_ key: String, _ value: Any) -> [(String, String)] {
        var components: [(String, String)] = []
        
        if let dictionary = value as? [String: Any] {
            for (nestedKey, value) in dictionary {
                components += self.queryComponents("\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [Any] {
            for value in array {
                components += self.queryComponents("\(key)[]", value)
            }
        } else {
            components.append((key, String(describing: value)))
        }
        
        return components
    }
}
