//
//  APIClient.swift
//  discussion-board
//
//  Created by Connor Przybyla on 7/3/22.
//

import Combine
import Foundation

protocol APIClient {
    func send<T: Decodable>(with request: URLRequest) -> AnyPublisher<T, NetworkingError>
}

class NetworkAPIClient: APIClient {
    private var urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    func send<T: Decodable>(with request: URLRequest) -> AnyPublisher<T, NetworkingError>  {
        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse else {
                    throw NetworkingError.badServerResponse
                }
                guard httpResponse.statusCode == 200 else {
                    throw NetworkingError.statusCode(httpResponse.statusCode)
                }
                
                return element.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { .underlying($0) }
            .eraseToAnyPublisher()
    }
}
