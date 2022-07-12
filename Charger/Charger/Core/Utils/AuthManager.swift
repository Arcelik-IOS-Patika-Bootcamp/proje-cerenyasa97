//
//  AuthManager.swift
//  Charger
//
//  Created by Ceren Yaşa on 11.07.2022.
//

import Foundation

class AuthManager {
    static var shared: AuthManager = AuthManager()
    var userInfo: LoginResponse?
}
