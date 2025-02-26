//
//  ContentView.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        VStack(spacing: 0) {
            tabContent
            TabBarView(selectedTab: $selectedTab)
        }
    }
    
    @ViewBuilder
    private var tabContent: some View {
        switch selectedTab {
        case .home:
            FoodAppView(viewModel: FoodListViewModel(serviceDI: ServiceDIContainer.shared))
        case .add:
            AddFoodView(viewModel: FoodListViewModel(serviceDI: ServiceDIContainer.shared))
        case .generator, .favorite, .planner:
            EmptyView()
        }
    }
}

#Preview {
    ContentView()
}
