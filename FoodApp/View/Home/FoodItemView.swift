//
//  FoodItemView.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import SwiftUI

struct FoodItemView: View {
    let food: FoodModelDatum
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            GeometryReader { geometry in
                ZStack(alignment: .topTrailing) {
                    CachedAsyncImage(url: food.imageURL?.first)
                        .scaledToFill()
                        .frame(width: geometry.size.width, height: 136)
                        .clipped()
                        .cornerRadius(12)

                    Button(action: {}) {
                        Image(systemName: food.isFavorite ?? false ? "heart.fill" : "heart")
                            .font(.title3)
                            .foregroundColor(food.isFavorite ?? false ? .red : .white)
                            .padding(8)
                    }
                }
            }
            .frame(height: 150)
            VStack(alignment: .leading, spacing: 8) {

                Text(food.name ?? "")
                    .font(CustomFont.satoshiBold.font(size: 16, weight: .semibold))
                    .fontWeight(.semibold)
                    .padding(.top, 10)
                
                HStack(spacing: 4) {
                    Image(systemName: "flame.fill")
                        .font(.caption)
                        .foregroundColor(.red)

                    Text("\(food.calories ?? 0) Calories")
                        .font(CustomFont.satoshiRegular.font(size: 12))
                        .foregroundColor(.secondary)
                }

                if let description = food.description, !description.isEmpty {
                    Text(description)
                        .font(CustomFont.satoshiRegular.font(size: 12))
                        .foregroundColor(.secondary)
                        .padding(.top, 2)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                }

                if let tags = food.foodTags, !tags.isEmpty {
                    HStack(spacing: 8) {
                        ForEach(tags, id: \.self) { tag in
                            Text(tag)
                                .font(CustomFont.satoshiRegular.font(size: 12))
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(Color(.systemGray6))
                                .cornerRadius(4)
                        }
                    }
                    .padding(.top, 4)
                }
            }
            .padding(12)
        }
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
    }
}
