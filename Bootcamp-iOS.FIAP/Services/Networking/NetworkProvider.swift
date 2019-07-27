//
//  NetworkProvider.swift
//  Bootcamp-iOS.FIAP
//
//  Created by Leandro Romano on 14/07/19.
//  Copyright © 2019 Leandro Romano. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case unauthorized
    case forbidden
    case notFound
    case mappingError
    case emptyResponseDataError
    case unknownError
}

struct NetworkProvider {
    
    static let shared: NetworkProvider = NetworkProvider()
    
    private init() { }
    
    func request<T: Codable>(_ url: String, completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        guard let requestUrl = URL(string: url) else {
            completionHandler(.failure(.badUrl))
            return
        }
        
        URLSession.shared.dataTask(with: requestUrl) { data, response, error in
            guard let data = data else {
                completionHandler(.failure(NetworkError.emptyResponseDataError))
                return
            }
            
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            
            if 200...299 ~= statusCode {
                do {
                    let decodableObject = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(.success(decodableObject))
                } catch {
                    completionHandler(.failure(NetworkError.mappingError))
                }
            }
            
            completionHandler(.failure(self.parseErrorFor(statusCode)))
        }.resume()
    }
    
    fileprivate func parseErrorFor(_ statusCode: Int) -> NetworkError {
        if statusCode == 401 { return .unauthorized }
        if statusCode == 403 { return .forbidden }
        if statusCode == 404 { return .notFound }
        return .unknownError
    }
    
}
