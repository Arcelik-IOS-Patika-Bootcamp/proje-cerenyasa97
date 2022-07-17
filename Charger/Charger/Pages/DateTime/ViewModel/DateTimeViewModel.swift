//
//  DateTimeViewModel.swift
//  Charger
//
//  Created by Ceren Yaşa on 16.07.2022.
//

import Foundation

class DateTimeViewModel: BaseViewModel{
    let service = DateTimeService()
    var selectedStation: Station
    var selectedDate: Date?
    
    init(station: Station){
        selectedStation = station
    }
    
    func getOccupiedTime() async {
        if let id = selectedStation.id{
            let result = await service.getOccupiedTimes(socketID: id, date: formatDate() )
            switch result{
            case .success(let occupiedTimes):
                print(occupiedTimes)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    private func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = selectedDate {
            return dateFormatter.string(from: date)
    } else {
        return dateFormatter.string(from: Date())
        }
    }
}
