//
//  StationsService.swift
//  Charger
//
//  Created by Ceren Yaşa on 14.07.2022.
//

import Foundation
import MapKit

class StationsService: NetworkManager{
    func getStations(coordinate: CLLocationCoordinate2D) async -> Result<Stations, RequestError>{
        return await sendRequest(endpoint: ChargerEndpoint.stations(lat: coordinate.latitude, long: coordinate.longitude), responseModel: Stations.self)
    }
}
