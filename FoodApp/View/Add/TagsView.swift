//
//  TagsView.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import SwiftUI

struct TagsView: View {
    @Binding var tags: [String]
    
    var body: some View {
        HStack {
            ForEach(tags, id: \.self) { tag in
                TagView(tag: tag) {
                    if let index = tags.firstIndex(of: tag) {
                        tags.remove(at: index)
                    }
                }
            }
        }
        .padding(.top, 8)
        .padding(.horizontal, 8)
    }
}
