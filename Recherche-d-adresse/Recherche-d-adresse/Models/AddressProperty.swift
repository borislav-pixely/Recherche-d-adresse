//
//  AddressProperty.swift
//  Recherche-d-adresse
//
//  Created by Borislav Borisov on 22/09/2023.
//

import Foundation

enum AddressPropertyType: String, Decodable {
    case housenumber
    case unknown
}

struct AddressProperty: Decodable {
    
    enum CodingKeys: CodingKey {
        case id
        case label
        case houseNumber
        case name
        case postcode
        case citycode
        case city
        case district
        case context
        case type
        case street
    }
    
    let id: String
    let label: String
    let houseNumber: String?
    let name: String
    let postcode: String
    let citycode: String
    let city: String
    let district: String?
    let context: String
    let type: AddressPropertyType
    let street: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.label = try container.decode(String.self, forKey: .label)
        self.houseNumber = try container.decodeIfPresent(String.self, forKey: .houseNumber)
        self.name = try container.decode(String.self, forKey: .name)
        self.postcode = try container.decode(String.self, forKey: .postcode)
        self.citycode = try container.decode(String.self, forKey: .citycode)
        self.city = try container.decode(String.self, forKey: .city)
        self.district = try container.decodeIfPresent(String.self, forKey: .district)
        self.context = try container.decode(String.self, forKey: .context)
        self.type = (try? container.decode(AddressPropertyType.self, forKey: .type)) ?? .unknown
        self.street = try container.decode(String.self, forKey: .street)
    }
}
