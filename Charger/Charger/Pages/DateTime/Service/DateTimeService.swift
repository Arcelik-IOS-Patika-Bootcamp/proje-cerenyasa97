//
//  DateTimeService.swift
//  Charger
//
//  Created by Ceren Yaşa on 16.07.2022.
//

import Foundation

class DateTimeService: NetworkManager {
    func getOccupiedTimes(socketID: Int, date: String) async -> Result<OccupiedTimes, RequestError>{
        return await sendRequest(endpoint: ChargerEndpoint.stationsOccupied(socketID: socketID, date: date), responseModel: OccupiedTimes.self)
    }
}
