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
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                searchField
                searchResults
            }
            .onChange(of: viewModel.isLoading) { isLoading in
                if isLoading {
                    isTextFieldFocused = false
                }
            }
        }
    }
    
    // MARK: - Private
    
    private var searchField: some View {
        TextField("Search for an address", text: $viewModel.query)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal)
            .focused($isTextFieldFocused)
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
            List(viewModel.searchResults, id: \.id) { property in
                if let coordinates = viewModel.getCoordinates(for: property) {
                    NavigationLink(destination: AddressDetailsView(coordinates: coordinates)) {
                        Text(property.label)
                    }
                } else {
                    Text(property.label)
                }
            }
        }
    }
}

struct AddressSearchView_Previews: PreviewProvider {
    static var previews: some View {
        AddressSearchView(viewModel: AddressSearchViewModel(addressAPI: AddressAPI(managerAPI: ManagerAPI())))
    }
}
