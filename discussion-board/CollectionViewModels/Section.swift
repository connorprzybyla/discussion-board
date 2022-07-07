//
//  Section.swift
//  discussion-board
//
//  Created by Connor Przybyla on 7/3/22.
//

import Foundation

struct Section: Decodable, Hashable {
    let id: Int
    let type: String
    let title: String
    let subtitle: String
    let items: [Thread]
}
