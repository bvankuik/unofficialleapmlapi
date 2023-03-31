//
//  Service.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 09/02/2023.
//

import Foundation

protocol Service {
    static func makeRequest(configuration: LeapML.Configuration) -> URLRequest
}

extension Service {
    static func makeRequest(configuration: LeapML.Configuration) -> URLRequest {
        var components = URLComponents()
        components.scheme = configuration.scheme
        components.host = configuration.host
        components.path = configuration.path
        
        guard let url = components.url else {
            fatalError("Can't build URL for some reason")
        }
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String else {
            fatalError("API key not found")
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "content-type": "application/json",
            "authorization": "Bearer \(apiKey)"
        ]
        return request
    }
}
