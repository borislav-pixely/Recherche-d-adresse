//
//  BaseManagerAPI.swift
//  Recherche-d-adresse
//
//  Created by Borislav Borisov on 22/09/2023.
//

import Foundation

enum HTTPMethod: String {
    case get
    case post
    case put
    case delete

    var value: String {
        return self.rawValue.uppercased()
    }
}

// This had been added for future testability to easily inject VMs with mocked ManagerAPIs.
protocol HTTPClient: AnyObject {
    func run<O: Decodable>(request: URLRequest) async -> Result<O, Error>
}

actor ManagerAPI: HTTPClient {

    private let session = URLSession(configuration: .default)

    // MARK: - Public

    func run<O: Decodable>(request: URLRequest) async -> Result<O, Error> {
        do {
            let (data, _) = try await session.data(for: request)
            let decoded = try JSONDecoder().decode(O.self, from: data)
            return .success(decoded)
        } catch {
            return .failure(error)
        }
    }
}
