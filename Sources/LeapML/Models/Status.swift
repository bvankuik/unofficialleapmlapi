//
//  Status.swift
//  TestLeapML
//
//  Created by Bart van Kuik on 27/02/2023.
//

import Foundation

/// This is the status of an inference job
public enum Status: String, Codable {
    case queued, finished
}
