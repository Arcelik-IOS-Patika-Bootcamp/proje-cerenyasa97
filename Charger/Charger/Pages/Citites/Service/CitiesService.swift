//
//  CitiesService.swift
//  Charger
//
//  Created by Ceren Yaşa on 13.07.2022.
//

import Foundation

class CitiesService: NetworkManager {
    func getCities(userID: Int) async -> Result<Cities, RequestError>{
        return await sendRequest(endpoint: ChargerEndpoint.cities, responseModel: Cities.self)
    }
}
