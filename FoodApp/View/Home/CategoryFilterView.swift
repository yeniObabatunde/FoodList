//
//  CategoryFilterView.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import SwiftUI

struct CategoryFilterView: View {
    @Binding var selectedCategory: FoodCategory
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(FoodCategory.allCases, id: \.self) { category in
                    CategoryPillView(
                        title: category.displayName,
                        isSelected: selectedCategory == category
                    )
                    .onTapGesture {
                        selectedCategory = category
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
