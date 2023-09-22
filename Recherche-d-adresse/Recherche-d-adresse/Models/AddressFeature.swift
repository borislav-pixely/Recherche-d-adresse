//
//  AddressFeature.swift
//  Recherche-d-adresse
//
//  Created by Borislav Borisov on 22/09/2023.
//

import Foundation

struct AddressFeature: Decodable {
    let geometry: AddressGeometry
    let properties: AddressProperty
}
