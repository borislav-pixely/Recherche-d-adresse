//
//  AddressSearchView.swift
//  Recherche-d-adresse
//
//  Created by Borislav Borisov on 22/09/2023.
//

import SwiftUI
import MapKit

struct AddressSearchView: View {

    @StateObject var viewModel: AddressSearchViewModel

    var body: some View {
        VStack {
            searchField
            searchResults
        }
    }
    
    // MARK: - Private
    
    private var searchField: some View {
        TextField("Search for an address", text: $viewModel.query)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal)
    }
    
    @ViewBuilder private var searchResults: some View {
        if viewModel.isLoading {
            VStack {
                Text("Searching...")
                ProgressView()
                Spacer()
            }
            .padding(.top, 10)
        } else {
            List(viewModel.searchResults, id: \.id) { result in
                Text(result.label)
            }
        }
    }
}

struct AddressSearchView_Previews: PreviewProvider {
    static var previews: some View {
        AddressSearchView(viewModel: AddressSearchViewModel(addressAPI: AddressAPI(managerAPI: ManagerAPI())))
    }
}
