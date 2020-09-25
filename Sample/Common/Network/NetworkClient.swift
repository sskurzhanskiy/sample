//
//  NetworkClient.swift
//  Sample
//
//  Created by Sergey Skurzhanskiy on 25.09.2020.
//

import Foundation

enum NetworkError: String, Error {
    case clientError = "Client error"
    case serverError = "Server error"
    case responseError = "Response format invalid"
}

class NetworkClient {
    private let session: URLSession

    init(configuration: URLSessionConfiguration) {
        session = URLSession.init(configuration: configuration)
    }

    func resumTask(request: URLRequest, completion: @escaping (Result<Any, NetworkError>) -> Void ) {
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(.clientError))
                return
            }

            guard let data = data else {
                completion(.failure(.clientError))
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(.failure(.serverError))
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                completion(.success(json))
            } catch {
                completion(.failure(.responseError))
            }
        }

        task.resume()
    }
}
