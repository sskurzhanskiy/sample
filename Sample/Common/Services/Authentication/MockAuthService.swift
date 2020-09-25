//
//  MockAuthService.swift
//  Sample
//
//  Created by Sergey Skurzhanskiy on 25.09.2020.
//

import Foundation

class MockAuthService: AuthService {
    var token: String?

    func authentication(completion: @escaping (Bool) -> Void) {
        let delay = DispatchTime.now() + DispatchTimeInterval.seconds(2)
        DispatchQueue.main.asyncAfter(deadline: delay) {
            completion(true)
        }
    }
}
