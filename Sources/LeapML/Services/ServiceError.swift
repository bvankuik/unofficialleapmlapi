//
//  ServiceError.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 09/02/2023.
//

import Foundation

public struct ServiceError: LocalizedError {
    public let message: String

    init(_ message: String) {
        self.message = message
    }

    public var errorDescription: String? {
        return message
    }
}
