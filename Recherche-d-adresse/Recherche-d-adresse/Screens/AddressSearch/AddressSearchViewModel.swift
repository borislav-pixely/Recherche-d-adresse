//
//  AddressSearchViewModel.swift
//  Recherche-d-adresse
//
//  Created by Borislav Borisov on 22/09/2023.
//

import Foundation

final class AddressSearchViewModel: ObservableObject {
    
    private let addressAPI: AddressAPI
    
    init(addressAPI: AddressAPI) {
        self.addressAPI = addressAPI
    }
    
    // MARK: - Public
    
    func search(for query: String) {
        // Fetch addresses
    }
}
