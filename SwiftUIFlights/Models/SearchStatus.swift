//
//  SearchStatus.swift
//  SwiftUIFlights
//
//  Created by Rob Broadwell on 12/31/22.
//

import Foundation

enum SearchStatus: Equatable {
    case idle
    case searching
    case error(String)
    case result
}
