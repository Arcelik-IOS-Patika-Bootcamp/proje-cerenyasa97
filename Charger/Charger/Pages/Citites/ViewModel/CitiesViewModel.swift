//
//  CitiesViewModel.swift
//  Charger
//
//  Created by Ceren Yaşa on 13.07.2022.
//

import Foundation

class CitiesViewModel: BaseViewModel{
    let service = CitiesService()
    var cities: Observable<Cities> = Observable([])
    
    init(){
        Task{
            await getCities()
        }
    }
    
    func getCities() async {
        if let id = AuthManager.shared.userInfo?.userID{
            let result = await service.getCities(userID: id)
            switch result{
            case .success(let cts):
                cities.value = cts
                return
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func navigateToStations(city: String, context: CitiesViewController){
        AppRouter.shared.route(to: AppRoute.stations.rawValue, from: context, parameters: [
            AppConstants.cityKey : city
        ])
    }
}
