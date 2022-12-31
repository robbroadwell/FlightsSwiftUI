//
//  SearchAirports.swift
//  SwiftUIFlights
//
//  Created by Rob Broadwell on 12/30/22.
//

import SwiftUI
import MapKit

struct SearchAirports: View {
    let location: LocationResult
    
    @StateObject private var localSearchService = LocalSearchService(filter: MKPointOfInterestFilter(including: [MKPointOfInterestCategory.airport]))
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject private(set) var state: AppState
    
    var body: some View {
        VStack {
            List {
                Section {
                    ForEach($localSearchService.results) { result in
                        Button {
                            if state.step == .departure {
                                state.departureAirport = result.wrappedValue
                            } else if state.step == .arrival {
                                state.arrivalAirport = result.wrappedValue
                            }

                            state.searchExpanded = false
                            state.searchString = ""

                            dismiss()

                        } label: {
                            Text(result.title.wrappedValue)
                        }
                    }
                }
                header: {
                    Text("AIRPORTS MATCHING \(location.title.uppercased())")
                }
            }
        }
        .task {
            await searchForAirportsNearCity()
        }
    }
    
    private func searchForAirportsNearCity() async {
        do {
            let placemarks = try await CLGeocoder().addressString(location.title)
            if let coordinate = placemarks?.first.map(\.location?.coordinate) ?? nil {
                localSearchService.completer.resultTypes = .pointOfInterest
                localSearchService.completer.region = regionForCoordinate(coordinate)
                localSearchService.query = "airport"
            }
            
        } catch let error {
            print("SearchAirports.task throws " + String(describing: error))
        }
    }
    
    private func regionForCoordinate(_ coordinate: CLLocationCoordinate2D) -> MKCoordinateRegion {
        MKCoordinateRegion(center: coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
}
