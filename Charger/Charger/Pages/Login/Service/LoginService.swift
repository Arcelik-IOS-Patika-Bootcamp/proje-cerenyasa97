//
//  LoginService.swift
//  Charger
//
//  Created by Ceren Yaşa on 4.07.2022.
//

import Foundation

class LoginService: NetworkManager {
    func logIn(request: LoginRequest) async -> Result<LoginResponse, RequestError> {
        return await sendRequest(endpoint: ChargerEndpoint.login(requestBody: request), responseModel: LoginResponse.self)
    }
}
