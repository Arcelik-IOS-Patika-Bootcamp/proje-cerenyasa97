//
//  LoginResponse.swift
//  Charger
//
//  Created by Ceren Yaşa on 3.07.2022.
//

import Foundation

// MARK: - Login
struct LoginResponse: Decodable {
    let email, token: String?
    let userID: Int?
}
