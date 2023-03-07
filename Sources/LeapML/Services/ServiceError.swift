//
//  ServiceError.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 09/02/2023.
//

import Foundation

/// Thrown when we receive an unexpected HTTP error code from the LeapML API, or when something goes wrong
/// when encoding a POST body, or decoding a response body.
public struct ServiceError: LocalizedError {
    public let message: String

    init(_ message: String) {
        self.message = message
    }

    public var errorDescription: String? {
        return message
    }
}
