//
//  HTTPClient.swift
//  Charger
//
//  Created by Ceren Yaşa on 4.07.2022.
//

import Foundation


protocol NetworkManager {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
}

extension NetworkManager {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async -> Result<T, RequestError> {
        guard let url = URL(string: endpoint.baseURL + endpoint.path) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        print(request)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        print(request.allHTTPHeaderFields)
        
        if let body = endpoint.body {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            request.httpBody = try? body.toJSONData()
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .success(responseModel as! T)
            }
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    return .failure(.decode)
                }
                return .success(decodedResponse)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}

extension Encodable {
    func toJSONData() throws -> Data? { try? JSONEncoder().encode(self) }
}
