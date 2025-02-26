//
//  SectionTitleView.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import SwiftUI

struct SectionTitleView: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(CustomFont.satoshiRegular.font(size: 16, weight: .semibold))
            Spacer()
        }
    }
}
