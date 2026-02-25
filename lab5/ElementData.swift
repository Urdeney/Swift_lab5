//
//  ElementData.swift
//  lab5
//
//  Created by UrdenVM on 25.02.2026.
//
import Foundation
import SwiftUI

struct ApiResponse: Hashable, Codable {
    var count: Int
    var results: [ElementData]
}

struct ElementData: Hashable, Codable {
    var index: String
    var name: String
    var level: Int
    var url: String
}
