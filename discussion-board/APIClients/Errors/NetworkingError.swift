//
//  NetworkingError.swift
//  discussion-board
//
//  Created by Connor Przybyla on 7/3/22.
//

import Foundation

enum NetworkingError: Error {
    case statusCode(Int)
    case badServerResponse
    case underlying(Error)
}
