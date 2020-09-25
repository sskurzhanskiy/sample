//
//  AuthService.swift
//  Sample
//
//  Created by Sergey Skurzhanskiy on 25.09.2020.
//

import Foundation

protocol AuthService {
    var token: String? { get }

    func authentication(completion: @escaping (Bool) -> Void)
}
