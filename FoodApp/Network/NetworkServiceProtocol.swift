//
//  NetworkServiceProtocol.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {

    func request<T: Decodable>(
        type: T.Type,
        endpoint: String,
        method: HTTPMethod,
        queryItems: [URLQueryItem]?,
        body: Data?,
        headers: [String: String]?
    ) -> AnyPublisher<T, NetworkError>
    
    func requestMultipart<T: Decodable>(
        type: T.Type,
        endpoint: String,
        method: HTTPMethod,
        formData: [String: Any],
        files: [(name: String, filename: String, data: Data, mimeType: String)]
    ) -> AnyPublisher<T, NetworkError>
}
