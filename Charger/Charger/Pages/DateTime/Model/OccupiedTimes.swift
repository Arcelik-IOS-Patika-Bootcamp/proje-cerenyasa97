//
//  OccupiedTimes.swift
//  Charger
//
//  Created by Ceren Yaşa on 16.07.2022.
//

import Foundation

struct OccupiedTimes: Codable {
    let stationID: Int?
    let stationCode: String?
    let sockets: [Socket]?
    let geoLocation: GeoLocation?
    let services: [String]?
    let stationName: String?
}

struct Day: Codable {
    let id: Int?
    let date: String?
    let timeSlots: [TimeSlot]?
}

struct TimeSlot: Codable {
    let slot: String?
    let isOccupied: Bool?
}
