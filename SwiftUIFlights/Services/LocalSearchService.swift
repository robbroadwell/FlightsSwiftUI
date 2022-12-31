//
//  LocalSearchService.swift
//  SwiftUIFlights
//
//  Created by Rob Broadwell on 12/30/22.
//

import Foundation
import Combine
import MapKit

class LocalSearchService: NSObject, ObservableObject {

    @Published var query: String = ""
    @Published var results: [LocationResult] = []
    @Published var status: SearchStatus = .idle

    var completer: MKLocalSearchCompleter
    private var cancellable: AnyCancellable?

    init(filter: MKPointOfInterestFilter = .excludingAll,
         region: MKCoordinateRegion = MKCoordinateRegion(.world),
         types: MKLocalSearchCompleter.ResultType = [.pointOfInterest, .query, .address] ) {
        
        completer = MKLocalSearchCompleter()
        
        super.init()
        
        completer.delegate = self
        completer.pointOfInterestFilter = filter
        completer.region = region
        completer.resultTypes = types
        
        connectQueryToCombinePipeline()
    }
    
    private func connectQueryToCombinePipeline() {
        cancellable = $query
            .receive(on: DispatchQueue.main)
            .throttle(for: .milliseconds(250), scheduler: RunLoop.main, latest: true)
            .sink(receiveValue: handleSearchFragment)
    }
    
    private func handleSearchFragment(_ fragment: String) {
        self.status = .searching
        
        if !fragment.isEmpty {
            self.completer.queryFragment = fragment
        } else {
            self.status = .idle
            self.results = []
        }
    }
    
    deinit {
        cancellable?.cancel()
        cancellable = nil
    }
}

// MARK: - Data Received

extension LocalSearchService: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results.map({ result in
            LocationResult(title: result.title, subtitle: result.subtitle)
        })
        
        self.status = .result
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        self.status = .error(error.localizedDescription)
    }
}
