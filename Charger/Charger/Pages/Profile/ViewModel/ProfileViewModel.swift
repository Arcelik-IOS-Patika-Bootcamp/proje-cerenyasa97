//
//  ProfileViewModel.swift
//  Charger
//
//  Created by Ceren Yaşa on 12.07.2022.
//

import Foundation

class ProfileViewModel: BaseViewModel{
    
    let service: ProfileService = ProfileService()
    
    func logOut(context: ProfileViewController) async -> Result<LogoutResponse, RequestError>? {
        if let id = AuthManager.shared.userInfo?.userID {
            let result = await service.logout(userID: id)
            switch result{
            case .success(_):
                AuthManager.shared.userInfo = nil
                AppRouter.shared.route(to: AppRoute.login.rawValue, from: context, parameters: nil)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        return nil
    }
}
