//
//  SearchContainer.swift
//  SwiftUIFlights
//
//  Created by Rob Broadwell on 12/29/22.
//

import SwiftUI
import Combine
import MapKit

struct SearchContainer: View {

    @StateObject private var locationService = LocalSearchService()
    @ObservedObject private(set) var state: AppState
    
    var body: some View {
        searchArea
            .shadow(radius: 2)
            .padding([.top], -8) // where is this padding coming from?
    }
    
    var searchArea: some View {
        NavigationStack {
            ZStack {
                Color.primaryGray
                
                VStack {
                    SearchField(state: state, loadingStatus: $locationService.status)
                    
                    if state.searchExpanded {
                        VStack {
                            if state.searchString == "" {
                                Color.clear
                                
                            } else {
                                SearchResults(results: $locationService.results, state: state)
                            }
                        }
                    }
                }
            }
            .background(Color.primaryGray)
        }
        .frame(maxHeight: maximumHeight)
        .onChange(of: state.searchString) { newValue in
            locationService.results = []
            locationService.query = newValue
        }
    }
    
    private var maximumHeight: CGFloat {
        state.searchExpanded ? .greatestFiniteMagnitude : 80
    }
}



// MARK: - Previews

struct SearchContainer_Previews: PreviewProvider {
    static var previews: some View {
        SearchContainer(state: .init())
    }
}
