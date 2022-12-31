//
//  SearchField.swift
//  SwiftUIFlights
//
//  Created by Rob Broadwell on 12/30/22.
//

import SwiftUI

struct SearchField: View {
    
    @ObservedObject private(set) var state: AppState
    @Binding var loadingStatus: SearchStatus
    @FocusState private var focusedField: FocusField?
    
    var body: some View {
        VStack {
            HStack {
                icon
                
                TextField("Search address", text: $state.searchString)
                    .focused($focusedField, equals: .search)
                    .autocorrectionDisabled(true)
                    
            }
            .padding([.all], 9)
            .background(Color.white)
            .cornerRadius(10)
        }
        .padding()
        .onChange(of: focusedField, perform: animateSearch)
    }
    
    var icon: some View {
        VStack {    
            if loadingStatus == .searching {
                ProgressView()
            } else {
                Image(systemName: "magnifyingglass")
                    .padding([.leading], 7)
            }
        }
    }
}

extension SearchField {
    private func animateSearch(_ field: (any Equatable)?) {
        withAnimation {
            state.searchExpanded = (field != nil || state.searchString.uppercased() != "")
        }
    }
}

extension SearchField {
    enum FocusField: Hashable {
        case search
    }
}
