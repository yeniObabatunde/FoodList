//
//  NetworkError.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import Foundation

struct APIErrorResponse: Decodable {
    let status: String
    let message: String
    let errors: [String: [String]]?
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(Int)
    case unknown(Error)
    case apiError(message: String, errors: [String: [String]]?)
    
    var localizedDescription: String {
            switch self {
            case .invalidURL:
                return "Invalid URL"
            case .noData:
                return "No data received"
            case .decodingError:
                return "Failed to decode response"
            case .serverError(let code):
                return "Server error with code: \(code)"
            case .apiError(let message, let errors):
                if let errors = errors, !errors.isEmpty {
                    // Join all error messages into one string
                    let errorMessages = errors.flatMap { (key, messages) in
                        messages.map { "\(key): \($0)" }
                    }.joined(separator: "\n")
                    return "\(message)\n\(errorMessages)"
                }
                return message
            case .unknown(let error):
                return error.localizedDescription
            }
        }
}



enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
    case patch = "PATCH"
}
