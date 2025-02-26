//
//  TagsEditorView.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import SwiftUI

struct TagsEditorView: View {
    @Binding var tags: [String]
    @Binding var tagInput: String
    let onAddTag: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            ZStack(alignment: .leading) {
                if tags.isEmpty && tagInput.isEmpty {
                    Text("Add a tag")
                        .foregroundColor(Color(.systemGray4))
                        .padding(.leading, 16)
                        .padding(.top, 16)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    if !tags.isEmpty {
                        TagsView(tags: $tags)
                    }
                    
                    TextField("", text: $tagInput, onCommit: onAddTag)
                        .padding(.horizontal, 16)
                        .padding(.vertical, tags.isEmpty ? 16 : 8)
                }
            }
            .background(Color.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(.systemGray4), lineWidth: 1)
            )
            
            Text("Press enter once you've typed a tag.")
                .font(.caption)
                .foregroundColor(Color(.systemGray))
                .padding(.top, 4)
        }
    }
}
