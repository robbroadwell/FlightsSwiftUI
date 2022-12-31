//
//  MapView.swift
//  SwiftUIFlights
//
//  Created by Rob Broadwell on 12/29/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    @ObservedObject private(set) var state: AppState
    
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 51.507222,
            longitude: -0.1275),
        span: MKCoordinateSpan(
            latitudeDelta: 0.5,
            longitudeDelta: 0.5))
    
    var body: some View {
        Map (
            coordinateRegion: $region,
            interactionModes: MapInteractionModes.all,
            showsUserLocation: true,
            userTrackingMode: $userTrackingMode
        )
        .edgesIgnoringSafeArea([.all])
    }
}
