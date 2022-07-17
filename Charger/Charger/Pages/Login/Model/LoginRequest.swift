//
//  LoginRequest.swift
//  Charger
//
//  Created by Ceren Yaşa on 3.07.2022.
//

import Foundation

// MARK: - LoginRequest
struct LoginRequest: Encodable{
    let email, deviceUDID: String
    
    enum CodingKeys: String, CodingKey {
            case email
            case deviceUDID
        }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(email, forKey: .email)
        try container.encode(deviceUDID, forKey: .deviceUDID)
    }
}
