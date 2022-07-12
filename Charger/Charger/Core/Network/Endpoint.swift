//
//  Endpoint.swift
//  Charger
//
//  Created by Ceren Yaşa on 1.07.2022.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethods { get }
    var header: [String: String]? { get }
    var body: Encodable? { get }
}
