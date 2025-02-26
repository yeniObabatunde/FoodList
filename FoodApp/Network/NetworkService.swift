//
//  NetworkService.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import Foundation
import Combine

final class NetworkService: NetworkServiceProtocol {
    
    private let baseURL: String
    private let session: URLSession
    
    init(baseURL: String, session: URLSession = .shared) {
        self.baseURL = baseURL
        self.session = session
    }
    
    private func handleResponse(data: Data, response: URLResponse) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse else {
            Logger.printIfDebug(data: "Invalid response: \(response)", logType: .error)
            throw NetworkError.noData
        }
        
        if !(200...299).contains(httpResponse.statusCode) {
            Logger.printIfDebug(data: "Server error: \(httpResponse.statusCode)", logType: .error)
           
            if let errorResponse = try? JSONDecoder().decode(APIErrorResponse.self, from: data) {
                Logger.printIfDebug(data: "API Error: \(errorResponse.message)", logType: .error)
                if let errors = errorResponse.errors {
                    for (key, messages) in errors {
                        Logger.printIfDebug(data: "- \(key): \(messages.joined(separator: ", "))", logType: .error)
                    }
                }
                throw NetworkError.apiError(message: errorResponse.message, errors: errorResponse.errors)
            }
            
            throw NetworkError.serverError(httpResponse.statusCode)
        }
        
        if let jsonString = String(data: data, encoding: .utf8) {
            Logger.printIfDebug(data: "Received JSON: \(jsonString)", logType: .success)
        }
        
        return data
    }
    
    func request<T: Decodable>(
        type: T.Type,
        endpoint: String,
        method: HTTPMethod,
        queryItems: [URLQueryItem]? = nil,
        body: Data? = nil,
        headers: [String: String]? = nil
    ) -> AnyPublisher<T, NetworkError> {
        let urlString = baseURL + endpoint
        guard var urlComponents = URLComponents(string: urlString) else {
            print("Invalid URL: \(endpoint)")
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            print("Invalid URL components: \(urlString)")
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        Logger.printIfDebug(data: "BASE URL: \(url)", logType: .info)
        var request = URLRequest(url: url, timeoutInterval: 10)
        request.httpMethod = method.rawValue
        request.httpBody = body
        
        headers?.forEach { request.addValue($1, forHTTPHeaderField: $0) }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { error in
                Logger.printIfDebug(data: "Network failure: \(error.localizedDescription)", logType: .error)
                return NetworkError.unknown(error)
            }
            .tryMap { [weak self] data, response -> Data in
                guard let self = self else { throw NetworkError.unknown(NSError(domain: "", code: -1, userInfo: nil)) }
                return try self.handleResponse(data: data, response: response)
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let networkError = error as? NetworkError {
                    return networkError
                }
                Logger.printIfDebug(data: "Decoding error: \(error.localizedDescription)", logType: .error)
                return NetworkError.decodingError
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
   
    func requestMultipart<T: Decodable>(
        type: T.Type,
        endpoint: String,
        method: HTTPMethod,
        formData: [String: Any],
        files: [(name: String, filename: String, data: Data, mimeType: String)]
    ) -> AnyPublisher<T, NetworkError> {
        let urlString = baseURL + endpoint
        guard let url = URL(string: urlString) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        Logger.printIfDebug(data: "BASE URL: \(url)", logType: .info)
       
        let boundary = "Boundary-\(UUID().uuidString)"
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let httpBody = createMultipartFormData(boundary: boundary, formData: formData, files: files)
        request.httpBody = httpBody
        
        Logger.printIfDebug(data: "Sending multipart request with \(formData.count) form fields and \(files.count) files", logType: .info)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .mapError { error in
                Logger.printIfDebug(data: "Network failure: \(error.localizedDescription)", logType: .error)
                return NetworkError.unknown(error)
            }
            .tryMap { [weak self] data, response -> Data in
                guard let self = self else { throw NetworkError.unknown(NSError(domain: "", code: -1, userInfo: nil)) }
                return try self.handleResponse(data: data, response: response)
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if let networkError = error as? NetworkError {
                    return networkError
                }
                Logger.printIfDebug(data: "Decoding error: \(error.localizedDescription)", logType: .error)
                return NetworkError.decodingError
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    private func createMultipartFormData(
        boundary: String,
        formData: [String: Any],
        files: [(name: String, filename: String, data: Data, mimeType: String)]
    ) -> Data {
        var body = Data()
       
        for (key, value) in formData {
            if let array = value as? [String] {
                for (index, item) in array.enumerated() {
                    body.append("--\(boundary)\r\n")
                    body.append("Content-Disposition: form-data; name=\"\(key)[\(index)]\"\r\n\r\n")
                    body.append("\(item)\r\n")
                }
            } else {
                body.append("--\(boundary)\r\n")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.append("\(value)\r\n")
            }
        }
        for (index, file) in files.enumerated() {
            body.append("--\(boundary)\r\n")
            body.append("Content-Disposition: form-data; name=\"\(file.name)[\(index)]\"; filename=\"\(file.filename)\"\r\n")
            body.append("Content-Type: \(file.mimeType)\r\n\r\n")
            body.append(file.data)
            body.append("\r\n")
        }
        body.append("--\(boundary)--\r\n")
        
        return body
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
