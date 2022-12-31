//
//  CLGeocoder+.swift
//  SwiftUIFlights
//
//  Created by Rob Broadwell on 12/31/22.
//

import CoreLocation

extension CLGeocoder {
    func addressString(_ fragment: String) async throws -> [CLPlacemark]? {
        try await withCheckedThrowingContinuation { continuation in
            CLGeocoder().geocodeAddressString(fragment) { result, error in
                continuation.resume(with: .success(result))
            }
        }
    }
}
