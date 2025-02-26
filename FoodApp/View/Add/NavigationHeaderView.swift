//
//  NavigationHeaderView.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import SwiftUI

struct NavigationHeaderView: View {
    let title: String
    let backAction: () -> Void
    
    var body: some View {
        HStack {
            Button(action: backAction) {
                Image(systemName: "chevron.left")
                    .foregroundColor(.black)
                    .padding(8)
            }
            
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            
            Spacer()
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 12)
        .background(Color.white)
        .overlay(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color(.systemGray5)),
            alignment: .bottom
        )
    }
}
