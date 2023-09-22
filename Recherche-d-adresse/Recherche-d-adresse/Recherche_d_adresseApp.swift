//
//  Recherche_d_adresseApp.swift
//  Recherche-d-adresse
//
//  Created by Borislav Borisov on 22/09/2023.
//

import SwiftUI

@main
struct Recherche_d_adresseApp: App {
    var body: some Scene {
        WindowGroup {
            AddressSearchView(viewModel: AddressSearchViewModel(addressAPI: AddressAPI(managerAPI: ManagerAPI())))
        }
    }
}
