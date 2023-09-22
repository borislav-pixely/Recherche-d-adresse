//
//  AddressDetailsView.swift
//  Recherche-d-adresse
//
//  Created by Borislav Borisov on 22/09/2023.
//

import SwiftUI
import MapKit

struct AddressDetailsView: View {
    
    struct AnnotationItem: Identifiable {
        let placemark: MKPlacemark
        
        var id: String {
            placemark.name ?? UUID().uuidString
        }
    }
    
    let coordinates: CLLocationCoordinate2D
    private let annotationItem: AnnotationItem
    private let coordinateSpan: MKCoordinateSpan
    
    init(coordinates: CLLocationCoordinate2D) {
        self.coordinates = coordinates
        self.annotationItem = AnnotationItem(placemark: MKPlacemark(coordinate: coordinates))
        self.coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    }
    
    var body: some View {
        Map(
            coordinateRegion: .constant(MKCoordinateRegion(center: coordinates, span: coordinateSpan)),
            annotationItems: [annotationItem]
        ) { place in
            MapPin(coordinate: coordinates, tint: .blue)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct AddressDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AddressDetailsView(coordinates: CLLocationCoordinate2D(latitude: 48.299549, longitude: 4.071492))
    }
}
