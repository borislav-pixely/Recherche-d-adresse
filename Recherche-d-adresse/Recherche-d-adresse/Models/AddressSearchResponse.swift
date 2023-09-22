//
//  AddressSearchResponse.swift
//  Recherche-d-adresse
//
//  Created by Borislav Borisov on 22/09/2023.
//

import Foundation

struct AddressSearchResponse: Decodable {
    let features: [AddressFeature]
}
