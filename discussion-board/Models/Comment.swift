//
//  Comment.swift
//  discussion-board
//
//  Created by Connor Przybyla on 7/10/22.
//

import Foundation

struct Comment: Decodable, Hashable {
    let id: Int
    let author: String
    let description: String
    let likes: Int
}
