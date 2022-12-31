//
//  SearchResults.swift
//  SwiftUIFlights
//
//  Created by Rob Broadwell on 12/31/22.
//

import SwiftUI

struct SearchResults: View {
    @Binding var results: [LocationResult]
    @ObservedObject private(set) var state: AppState
    
    var body: some View {
        List {
            Section {
                ForEach(results) { location in
                    NavigationLink(value: location) {
                        HStack {
                            Text(location.title)
                            Text("(\(location.subtitle))")
                        }
                    }
                }
            } header: {
                Text("PLACES MATCHING \(state.searchString.uppercased())")
            }
        }
        .navigationDestination(for: LocationResult.self) { result in
            SearchAirports(location: result, state: state)
        }
    }
}
