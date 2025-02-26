//
//  TextEditorFieldView.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import SwiftUI

struct TextEditorFieldView: View {
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        TextEditor(text: $text)
            .padding(12)
            .frame(height: 100)
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(.systemGray4), lineWidth: 1)
            )
            .overlay(
                Group {
                    if text.isEmpty {
                        Text(placeholder)
                            .foregroundColor(Color(.systemGray4))
                            .padding(.horizontal, 16)
                            .padding(.vertical, 12)
                            .allowsHitTesting(false)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    }
                }
            )
    }
}
