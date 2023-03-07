//
//  InferenceImage.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 13/02/2023.
//

import Foundation

/// Model for the image of an inference job, which has an array of these.
public struct InferenceImage: Codable, Identifiable {
    public let id: String
    public let uri: String
    public let createdAt: Date
    public var url: URL? {
        URL(string: self.uri)
    }
}
