//
//  OverlayButton.swift
//  SwiftUIFlights
//
//  Created by Rob Broadwell on 12/29/22.
//

import SwiftUI

struct OverlayButton: View {
    @ObservedObject private(set) var state: AppState
    
    var body: some View {
        switch state.step {
            case .departure: departure
            case .arrival: arrival
            case .result: result
        }
    }
    
    var departure: some View {
        Button {

        } label: {
            HStack {
                Image(systemName: "airplane.departure")
                Text("Select Departure")
                    .font(.system(size: 13, weight: .semibold))
            }
        }
        .buttonStyle(OverlayButtonStyle())
    }
    
    var arrival: some View {
        Button {

        } label: {
            HStack {
                Image(systemName: "airplane.arrival")
                Text("Select Arrival")
                    .font(.system(size: 13, weight: .semibold))
            }
        }
        .buttonStyle(OverlayButtonStyle())
    }
    
    var result: some View {
        Button {
            state.departureAirport = nil
            state.arrivalAirport = nil
            state.searchString = ""
            state.searchExpanded = false
            
        } label: {
            HStack {
                VStack {
                    HStack {
                        Image(systemName: "airplane.departure")
                        Text(state.departureAirport?.title ?? "")
                            .font(.system(size: 13, weight: .semibold))
                    }
                    HStack {
                        Image(systemName: "airplane.arrival")
                        Text(state.arrivalAirport?.title ?? "")
                            .font(.system(size: 13, weight: .semibold))
                    }
                }
                
                Image(systemName: "xmark")
            }
        }
        .buttonStyle(OverlayButtonStyle())
    }
}

