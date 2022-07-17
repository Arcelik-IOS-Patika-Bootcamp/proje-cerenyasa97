//
//  StationsViewModel.swift
//  Charger
//
//  Created by Ceren Yaşa on 14.07.2022.
//

import Foundation
import MapKit

class StationsViewModel{
    let city: String
    let service = StationsService()
    var stationsFromService: Stations?
    var stations: Observable<Stations> = Observable([])
    var selectedTags = [String]()
    var sliderValue: Float = 3.0
    
    init(selectedCity: String){
        city = selectedCity
    }
    
    func getStations() async {
        let locationManager = CLLocationManager()
        if let coordinate = locationManager.location?.coordinate{
            let result = await service.getStations(coordinate: coordinate)
            switch result{
            case .success(let stations):
                stationsFromService = stations.filter({ station in
                    return station.geoLocation?.province?.lowercased().contains(city.lowercased()) ?? false
                })
                self.stations.value = stationsFromService ?? []
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    func selectTag(tag: String?){
        if let tag = tag {
            let index = selectedTags.firstIndex { element in
                element == tag
            }
            if let index = index {
                selectedTags.remove(at: index)
            } else {
                selectedTags.append(tag)
            }
        }
    }
    
    func filterStations(){
        if let sfs = stationsFromService{
            stations.value = sfs.filter({ station in
                if let km = station.distanceInKM{
                    return Float(km) <= sliderValue.rounded()
                } else {
                    return false
                }
            })
            selectedTags.forEach { tag in
                if ChargeType.allCases.map({ $0.rawValue }).contains(tag){
                    stations.value = stations.value.filter({ station in
                        station.sockets?.contains(where: { socket in
                            return socket.chargeType?.rawValue == tag
                        }) ?? false
                    })
                }
                if SocketType.allCases.map({ $0.rawValue }).contains(tag){
                    stations.value = stations.value.filter({ station in
                        station.sockets?.contains(where: { socket in
                            return socket.socketType?.rawValue == tag
                        }) ?? false
                    })
                }
                if Service.allCases.map({ $0.rawValue }).contains(tag){
                    stations.value = stations.value.filter({ station in
                        station.services?.contains(where: { service in
                            return service.rawValue == tag
                        }) ?? false
                    })
                }
            }
        }
    }
    
    func changeKm(value: Float){
        sliderValue = value
    }
    
    func navigateToDateTime(station: Station, context: StationsViewController){
        AppRouter.shared.route(to: AppRoute.dateTime.rawValue, from: context, parameters: [
            AppConstants.stationKey : station
        ])
    }
}
