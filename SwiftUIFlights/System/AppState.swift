//
//  DIContainer.swift
//  SwiftUIFlights
//
//  Created by Rob Broadwell on 12/29/22.
//

import Foundation
import SwiftUI

class AppState: ObservableObject {
    @Published var departureAirport: LocationResult?
    @Published var arrivalAirport: LocationResult?
    @Published var searchString: String = ""
    @Published var searchExpanded: Bool = false
    
    var step: Step {
        if departureAirport == nil { return .departure }
        if arrivalAirport == nil { return .arrival }
        return .result
    }
    
    enum Step {
        case departure
        case arrival
        case result
    }
    
    required init(departureAirport: LocationResult? = nil,
                  arrivalAirport: LocationResult? = nil,
                  searchString: String = "",
                  searchExpanded: Bool = false) {
        self.departureAirport = departureAirport
        self.arrivalAirport = arrivalAirport
        self.searchString = searchString
        self.searchExpanded = searchExpanded
    }
}

extension AppState {
    static var preview: Self {
        .init()
    }
}
