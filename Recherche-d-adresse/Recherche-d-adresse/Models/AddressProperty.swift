//
//  AddressProperty.swift
//  Recherche-d-adresse
//
//  Created by Borislav Borisov on 22/09/2023.
//

import Foundation

enum AddressPropertyType: String, Decodable {
    case housenumber
}

struct AddressProperty: Decodable {
    let id: String
    let label: String
    let houseNumber: String?
    let name: String
    let postcode: String
    let citycode: String
    let city: String
    let district: String?
    let context: String
    let type: String
    let street: String
}
