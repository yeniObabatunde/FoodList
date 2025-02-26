//
//  TagView.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import SwiftUI

struct TagView: View {
    let tag: String
    let onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: 4) {
            Text(tag)
                .font(.caption)
                .padding(.leading, 8)
                .foregroundColor(.black)
            
            Button(action: onDelete) {
                Image(systemName: "xmark")
                    .font(.system(size: 10))
                    .foregroundColor(.black)
                    .padding(4)
            }
        }
        .padding(.vertical, 4)
        .background(Color(.systemGray5))
        .cornerRadius(4)
    }
}
