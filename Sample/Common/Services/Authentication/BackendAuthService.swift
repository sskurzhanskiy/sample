//
//  MockAuthService.swift
//  Sample
//
//  Created by Sergey Skurzhanskiy on 25.09.2020.
//

import Foundation

private let authEndpoint = "oauth2/token"

class BackendAuthService: AuthService {
    private let networkClient: NetworkClient
    var token: String?

    init() {
        networkClient = NetworkClient.init(configuration: URLSessionConfiguration.default)
    }

    func authentication(completion: @escaping (Bool) -> Void) {
        guard let request = authRequest() else {
            completion(false)
            return
        }

        networkClient.resumTask(request: request) { [weak self] result in
            switch result {
            case .success(let object):
                self?.token = object as? String
                completion(true)
            case .failure(_):
                completion(false)
            }
        }
    }

    // MARK: private methods
    private var encodingTwitterToken: String {
        let twitterKey = Environment.shared.twitterKey.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        let twitterSecret = Environment.shared.twitterSecret.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""

        return (twitterKey + ":" + twitterSecret).data(using: .utf8)?.base64EncodedString() ?? ""
    }

    private var authUrl: URL? {
        var url = URL(string: Environment.shared.baseUrl)
        url?.appendPathComponent(authEndpoint)

        return url
    }

    private func authRequest() -> URLRequest? {
        guard let url = authUrl else { return nil }

        var request = URLRequest.init(url: url)
        request.httpMethod = "POST"
        request.addValue("Basic \(encodingTwitterToken)", forHTTPHeaderField: "Authorization")
        request.addValue("application/x-www-form-urlencoded;charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = "grant_type=client_credentials".data(using: .utf8)

        return request
    }
}
