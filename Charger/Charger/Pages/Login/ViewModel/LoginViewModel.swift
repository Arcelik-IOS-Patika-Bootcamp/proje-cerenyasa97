//
//  LoginViewModel.swift
//  Charger
//
//  Created by Ceren Yaşa on 3.07.2022.
//

import Foundation
import UIKit

class LoginViewModel: BaseViewModel{
    let service = LoginService()
    let context: LoginViewController
    
    init(ctx: LoginViewController){
        context = ctx
    }
    
    func logIn(email: String, udid: String) async ->  Result<LoginResponse, RequestError>{
        let result = await service.logIn(request: LoginRequest(email: email, deviceUDID: udid))
        switch result{
        case .failure(let requestError):
            print(requestError)
            break
        case .success(let response):
            AuthManager.shared.userInfo = response
            AppRouter.shared.route(to: AppRoute.appointments.rawValue, from: context, parameters: nil)
            break
        }
        return result
    }
}
