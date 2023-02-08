//
//  NetworkService.swift
//  ToDoListApp
//
//  Created by Nathan Batista on 03/02/23.
//

import Foundation
import Combine

enum HTTPMethods: String {
    case GET = "GET"
    case POST = "POST"
    case DELETE = "DELETE"
    case UPDATE = "UPDATE"
}

enum HTTPError: Error {
    case invalidURL
    case notFound
}

class NetworkService {
    
    init() {}
        
    func makeRequest<T: Decodable>(urlString: String,
                                   method: HTTPMethods = .GET,
                                   body: Data? = nil,
                                   queryItems: [String: String]? = nil ) -> AnyPublisher<T, Error> {
        
        return Future<T, Error> { promise in
            
            var url = URLComponents(string: urlString)
            
            var query = [URLQueryItem]()
            queryItems?.forEach { key, value in
                query.append(URLQueryItem(name: key, value: value))
            }
            
            url?.queryItems = query
            
            guard let url = url?.url else {
                promise(.failure(HTTPError.invalidURL))
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.httpBody = body
            
            let _ = URLSession.shared.dataTaskPublisher(for: request)
                .map(\.data)
                .decode(type: T.self, decoder: JSONDecoder())
                .sink { completion in
                    switch completion {
                    case .failure(let error):
                        promise(.failure(error))
                    case .finished:
                        break
                    }
                } receiveValue: { decodedValue in
                    promise(.success(decodedValue))
                }

        }.eraseToAnyPublisher()
    }
    
}

