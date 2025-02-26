//
//  HeaderView.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import SwiftUI


struct HeaderView: View {
    var body: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
            Spacer()
            Button(action: {}) {
                Image(systemName: "bell")
                    .font(.title3)
                    .foregroundColor(.primary)
                    .frame(width: 40, height: 40)
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(radius: 10)
            }

        }
        .padding(15)
        VStack {
            Text("Hey there, Lucy!")
                .multilineTextAlignment(.leading)
                .font(CustomFont.satoshiBold.font(size: 16))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Are you excited to create a tasty dish today?")
                .font(CustomFont.satoshiRegular.font(size: 14))
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.horizontal, 15)
    }
}

#Preview {
    HeaderView()
}
