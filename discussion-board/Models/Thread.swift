//
//  Thread.swift
//  discussion-board
//
//  Created by Connor Przybyla on 7/6/22.
//

import Foundation

struct Thread: Decodable, Hashable {
    let id: Int
    let tagline: String
    let name: String
    let subtitle: String
}
