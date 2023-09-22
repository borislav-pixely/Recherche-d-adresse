//
//  AddressSearchViewModel.swift
//  Recherche-d-adresse
//
//  Created by Borislav Borisov on 22/09/2023.
//

import Foundation
import Combine
import CoreLocation

final class AddressSearchViewModel: ObservableObject {
    
    @Published var query: String = ""
    @Published private var results: [AddressFeature] = []
    @Published private(set) var isLoading = false
    
    private var previousQuery: String = ""
    private var cancellables = Set<AnyCancellable>()
    private let addressAPI: AddressAPI
    
    var searchResults: [AddressProperty] {
        results
            .map { $0.property }
            .filter { $0.type == .housenumber }
    }
    
    init(addressAPI: AddressAPI) {
        self.addressAPI = addressAPI
        setupObservers()
    }
    
    // MARK: - Public
    
    func getCoordinates(for property: AddressProperty) -> CLLocationCoordinate2D? {
        guard let coordinates = results.first(where: { $0.property.id == property.id })?.geometry.coordinates,
              coordinates.count == 2 else {
            return nil
        }
        
        return CLLocationCoordinate2D(latitude: coordinates[1], longitude: coordinates[0])
    }
    
    // MARK: - Private
    
    private func setupObservers() {
        $query
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .sink { [weak self] _ in
                guard let self, !self.query.isEmpty, previousQuery != query else { return }
                self.isLoading = true
                self.previousQuery = query
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
                    self?.results = response.features
                case .failure(let error):
                    // TODO: Handle error
                    print("Error: \(error.localizedDescription)")
                    self?.results.removeAll()
                }
                
                self?.isLoading = false
            }
        }
    }
}
