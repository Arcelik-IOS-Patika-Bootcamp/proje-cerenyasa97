//
//  AppointmentsViewModel.swift
//  Charger
//
//  Created by Ceren Yaşa on 12.07.2022.
//

import Foundation

class AppointmentsViewModel: BaseViewModel{
    func navigateToProfile(context: AppointmentsViewController){
        AppRouter.shared.route(to: AppRoute.profile.rawValue, from: context, parameters: nil)
    }
    
    func navigateToCities(context: AppointmentsViewController){
        AppRouter.shared.route(to: AppRoute.cities.rawValue, from: context, parameters: nil)
    }
}
