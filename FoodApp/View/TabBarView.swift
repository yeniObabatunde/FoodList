//
//  TabBarView.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import SwiftUI

struct TabBarView: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        HStack {
            ForEach(Tab.allCases, id: \.self) { tab in
                Spacer()
                
                Button(action: {
                    selectedTab = tab
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: tab.iconName)
                            .font(.title3)
                        
                        Text(tab.title)
                            .font(.caption2)
                    }
                    .foregroundColor(selectedTab == tab ? .blue : .gray)
                }
                
                Spacer()
            }
        }
        .padding(.vertical, 8)
        .background(
            Color(.systemBackground)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: -2)
        )
    }
}
