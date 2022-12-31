//
//  AppMain.swift
//  SwiftUIFlights
//
//  Created by Rob Broadwell on 12/29/22.
//

import SwiftUI

@main
struct AppMain: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView(state: AppState())
        }
    }
}
