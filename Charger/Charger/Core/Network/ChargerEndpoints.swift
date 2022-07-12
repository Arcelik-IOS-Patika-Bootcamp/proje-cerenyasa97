//
//  ChargerEndpoints.swift
//  Charger
//
//  Created by Ceren Yaşa on 3.07.2022.
//

import Foundation

enum ChargerEndpoint{
    case login(requestBody: LoginRequest),
         logout(userID: Int),
    cities,
    stations,
    getAppointments,
    appointments,
    cancelAppointments
}

extension ChargerEndpoint: Endpoint{
    var baseURL: String {
        return "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/"
    }
    
    var body: Encodable?{
        switch self{
        case .login(let requestBody):
            return requestBody
        default:
            return nil
        }
    }
    
    var path: String {
        switch self{
        case .login:
            return "auth/login"
        case .logout(let id):
            return "auth/logout/\(id)";
        case .cities:
            return "provinces";
        case .stations:
            return "stations/";
        case .getAppointments:
            return "appointments/make";
        case .appointments:
            return "appointments/";
        case .cancelAppointments:
            return "appointments/cancel/"
        }
        }
    
    var method: RequestMethods {
        switch self {
        case .login, .logout, .getAppointments:
            return RequestMethods.post
        case .cancelAppointments:
            return RequestMethods.delete
        case .cities, .stations, .appointments:
            return RequestMethods.get
        }
    }
    
    var header: [String : String]? {
        switch self {
        case .login:
            return [
                "Content-Type": "application/json;charset=utf-8"
            ]
        default:
            if let token = AuthManager.shared.userInfo?.token{
                return [
                    "token": "\(token)",
                    "Content-Type": "application/json;charset=utf-8"
                ]
            } else {
                return nil
            }
        }
    }
}
