//
//  ContentView.swift
//  SwiftUIFlights
//
//  Created by Rob Broadwell on 12/29/22.
//

import SwiftUI
import MapKit

// TODO: remove
struct City: Decodable, Hashable  {
    let name: String
}

struct ContentView: View {
    @ObservedObject private(set) var state: AppState
    
    var body: some View {
        ZStack {
            
            VStack {
                MapView(state: state)
                
                if state.step != .result {
                    SearchContainer(state: state)
                }
            }
            
            VStack {
                OverlayButton(state: state)
                Color.clear
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(state: .preview)
    }
}
