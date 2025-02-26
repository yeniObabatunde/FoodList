//
//  CategoryPillView.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import SwiftUI

struct CategoryPillView: View {
    let title: String
    let isSelected: Bool
    
    var body: some View {
        Text(title)
            .font(CustomFont.satoshiMedium.font(size: 14))
            .fontWeight(isSelected ? .semibold : .regular)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(isSelected ? Color.blue : Color(.systemGray6))
            .foregroundColor(isSelected ? .white : .primary)
            .cornerRadius(10)
    }
}
