//
//  AddressSearchViewModel.swift
//  Recherche-d-adresse
//
//  Created by Borislav Borisov on 22/09/2023.
//

import Foundation
import Combine

final class AddressSearchViewModel: ObservableObject {
    
    @Published var query: String = ""
    @Published private(set) var searchResults: [AddressProperty] = []
    @Published private(set) var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    private let addressAPI: AddressAPI
    
    init(addressAPI: AddressAPI) {
        self.addressAPI = addressAPI
        setupObservers()
    }
    
    // MARK: - Private
    
    private func setupObservers() {
        $query
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .sink { [weak self] _ in
                guard let self, !self.query.isEmpty else { return }
                self.isLoading = true
                self.search()
            }
            .store(in: &cancellables)
    }
    
    private func search() {
        Task {
            let result = await addressAPI.getAddresses(usingQuery: query)

            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let response):
                    self?.searchResults = response.features
                        .map { $0.properties }
                        .filter { $0.type == "housenumber" }
                case .failure(let error):
                    // TODO: Handle error
                    print("Error: \(error.localizedDescription)")
                    self?.searchResults.removeAll()
                }
                
                self?.isLoading = false
            }
        }
    }
}
