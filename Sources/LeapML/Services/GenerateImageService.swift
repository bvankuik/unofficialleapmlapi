//
//  GenerateImageService.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 08/02/2023.
//

import Foundation
import OSLog

// https://docs.leapml.dev/reference/inferencescontroller_create-1
public struct GenerateImageService: Service {
    public static func call(requestBody: RequestBody) async throws -> Inference {
        var request = makeRequest()
        
        guard let httpBody = try? JSONEncoder().encode(requestBody) else {
            throw ServiceError("Error encoding body")
        }
        
        if let bodyString = String(data: httpBody, encoding: .utf8) {
            os_log("Submitting request to generate image with body:\n%@", log: .default, type: .debug, bodyString)
        }
        request.httpMethod = "POST"
        request.httpBody = httpBody

        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ServiceError("URL response is not HTTPURLResponse")
        }
        os_log("Server statusCode: %d", log: .default, type: .debug, httpResponse.statusCode)

        if !([200, 201].contains(httpResponse.statusCode)) {
            os_log("Unexpected server statusCode: %d", log: .default, type: .error, httpResponse.statusCode)
            if let responseString = String(data: data, encoding: .utf8) {
                os_log("Response:\n%@", log: .default, type: .debug, responseString)
            }
            throw ServiceError("Server error, status code: \(httpResponse.statusCode)")
        }
        
        return try Utils.makeDecoder().decode(Inference.self, from: data)
    }
}

extension GenerateImageService {
    public struct RequestBody: Codable {
        public init(prompt: String, negativePrompt: String, version: String? = nil, steps: Int, width: Int, height: Int, numberOfImages: Int, promptStrength: Int, webhookUrl: String? = nil) {
            self.prompt = prompt
            self.negativePrompt = negativePrompt
            self.version = version
            self.steps = steps
            self.width = width
            self.height = height
            self.numberOfImages = numberOfImages
            self.promptStrength = promptStrength
            self.webhookUrl = webhookUrl
        }
        
        public var prompt: String
        public var negativePrompt: String
        public var version: String?
        public var steps: Int
        public var width: Int
        public var height: Int
        public var numberOfImages: Int
        public var promptStrength: Int
        var seed: Int {
            Int.random(in: 1..<(2<<15))
        }
        public var webhookUrl: String?
    }
    
}
