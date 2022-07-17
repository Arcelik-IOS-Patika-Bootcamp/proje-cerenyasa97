//
//  Stations.swift
//  Charger
//
//  Created by Ceren Yaşa on 14.07.2022.
//

import Foundation

// MARK: - Station
struct Station: Codable {
    let id: Int?
    let stationCode: String?
    let sockets: [Socket]?
    let socketCount, occupiedSocketCount: Int?
    let distanceInKM: Double?
    let geoLocation: GeoLocation?
    let services: [Service]?
    let stationName: String?
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.geoLocationTask(with: url) { geoLocation, response, error in
//     if let geoLocation = geoLocation {
//       ...
//     }
//   }
//   task.resume()

// MARK: - GeoLocation
struct GeoLocation: Codable {
    let longitude, latitude: Double?
    let province, address: String?
}

enum Service: String, Codable, CaseIterable {
    case büfe = "Büfe"
    case otopark = "Otopark"
    case wiFi = "Wi-Fi"
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.socketTask(with: url) { socket, response, error in
//     if let socket = socket {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Socket
struct Socket: Codable {
    let socketID: Int?
    let socketType: SocketType?
    let chargeType: ChargeType?
    let power: Int?
    let powerUnit: PowerUnit?
    let socketNumber: Int?
}

enum ChargeType: String, Codable, CaseIterable {
    case ac = "AC"
    case dc = "DC"
}

enum PowerUnit: String, Codable {
    case kVa = "kVa"
    case kW = "kW"
}

enum SocketType: String, Codable, CaseIterable {
    case chAdeMO = "CHAdeMO"
    case csc = "CSC"
    case type2 = "Type-2"
}

typealias Stations = [Station]

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}
