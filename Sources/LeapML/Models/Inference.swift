//
//  Inference.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 13/02/2023.
//

import Foundation

// An inference only has image names, without their URIs.
public struct Inference: Codable {
    public let id, prompt, negativePrompt: String
    public let createdAt: Date
    public let seed, width, height, promptStrength: Int
    public let numberOfImages, steps: Int
    public let status: Status
    public let images: [String]
    public let modelID: String

    enum CodingKeys: String, CodingKey {
        case id, createdAt, prompt, negativePrompt, seed, width, height, promptStrength, numberOfImages, status,
             steps, images
        case modelID = "modelId"
    }
}
