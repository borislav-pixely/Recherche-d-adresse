//
//  AddressFeature.swift
//  Recherche-d-adresse
//
//  Created by Borislav Borisov on 22/09/2023.
//

import Foundation

struct AddressFeature: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case geometry
        case property = "properties"
    }
    
    let geometry: AddressGeometry
    let property: AddressProperty
}
