//
//  AddButtonView.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import SwiftUI

struct AddButtonView: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("Add food")
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .cornerRadius(8)
        }
        .padding(.vertical, 24)
    }
}
