//
//  ProfileService.swift
//  Charger
//
//  Created by Ceren Yaşa on 12.07.2022.
//

import Foundation

class ProfileService: NetworkManager{
    func logout(userID: Int) async -> Result<LogoutResponse, RequestError>{
        return await sendRequest(endpoint: ChargerEndpoint.logout, responseModel: LogoutResponse.self)
    }
}
