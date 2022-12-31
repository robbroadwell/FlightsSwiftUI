//
//  OverlayButtonStyle.swift
//  SwiftUIFlights
//
//  Created by Rob Broadwell on 12/29/22.
//

import SwiftUI

struct OverlayButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(10)
            .background(Color.init(white: 0.95))
            .foregroundColor(.black)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}
