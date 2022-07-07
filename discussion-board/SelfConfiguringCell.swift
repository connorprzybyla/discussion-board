//
//  SelfConfiguringCell.swift
//  discussion-board
//
//  Created by Connor Przybyla on 7/6/22.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseIdentifier: String { get }
    func configure(with thread: Thread)
}
