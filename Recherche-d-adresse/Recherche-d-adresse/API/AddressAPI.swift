//
//  AddressAPI.swift
//  Recherche-d-adresse
//
//  Created by Borislav Borisov on 22/09/2023.
//

import Foundation

final class AddressAPI: BaseAPI {
    
    private let managerAPI: ManagerAPI

    init(managerAPI: ManagerAPI) {
        self.managerAPI = managerAPI
    }

    func getAddresses(usingQuery query: String) async -> Result<AddressSearchResponse, Error> {
        let searchQuery = URLQueryItem(name: "q", value: query)
        let typeQuery = URLQueryItem(name: "type", value: "housenumber")
        
        let request = urlRequest(withPath: "search/", queryItems: [searchQuery, typeQuery], method: .get)
        return await managerAPI.run(request: request)
    }
}
