//
//  InferenceImage.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 13/02/2023.
//

import Foundation

public struct InferenceImage: Codable, Identifiable {
    public let id: String
    public let uri: String
    public let createdAt: Date
    public var url: URL? {
        URL(string: self.uri)
    }
}
