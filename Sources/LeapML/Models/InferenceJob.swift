//
//  InferenceJob.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 13/02/2023.
//

import Foundation

/// Model for an inference job that has images that include an URI.
public struct InferenceJob: Identifiable {
    public let id, prompt, negativePrompt: String
    public let status: Status
    public let seed, width, height, numberOfImages: Int
    public let steps: Int
    public let createdAt: Date
    public let promptStrength: Int
    public let images: [InferenceImage]
    public let modelID: String

    enum CodingKeys: String, CodingKey {
        case id, status, prompt, negativePrompt, seed, width, height, numberOfImages, steps, createdAt, promptStrength,
             images
        case modelID = "modelId"
    }
}

extension InferenceJob: Decodable {}
