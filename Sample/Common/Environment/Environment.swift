//
//  Environment.swift
//  Sample
//
//  Created by Sergey Skurzhanskiy on 24.09.2020.
//

import Foundation

class Environment {
    static let shared = Environment()

    let baseUrl: String
    let twitterSecret: String
    let twitterKey: String

    private init() {
        let environmentPath = Bundle.main.path(forResource: "Environment", ofType: ".plist")
        let environment = NSDictionary(contentsOfFile: environmentPath ?? "")

        let key = "Debug"
        baseUrl = (environment?["baseUrl"] as? String) ?? ""
        twitterSecret = (environment?["twitterCustomerSecret"] as? String) ?? ""
        twitterKey = (environment?["twitterCustomerKey"] as? String) ?? ""
    }
}
