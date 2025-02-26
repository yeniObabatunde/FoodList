//
//  ImageUploadSectionView.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 26/02/2025.
//

import SwiftUI

struct ImageUploadSectionView: View {
    let onTakePhoto: () -> Void
    let onUpload: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            ImageUploadButton(
                title: "Take photo",
                systemName: "camera",
                action: onTakePhoto
            )
            
            ImageUploadButton(
                title: "Upload",
                systemName: "square.and.arrow.up",
                action: onUpload
            )
        }
    }
}

struct ImageUploadButton: View {
    let title: String
    let systemName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                Image(systemName: systemName)
                    .font(.system(size: 24))
                    .foregroundColor(.gray)
                    .frame(height: 36)
                
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 90)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(.systemGray4), lineWidth: 1)
            )
        }
    }
}

struct SelectedImagesView: View {
    let images: [UIImage]
    let onDelete: (Int) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(0..<images.count, id: \.self) { index in
                    ZStack(alignment: .topTrailing) {
                        Image(uiImage: images[index])
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 60)
                            .cornerRadius(6)
                            .clipped()
                        
                        Button(action: {
                            onDelete(index)
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.white)
                                .background(Color.black.opacity(0.6))
                                .clipShape(Circle())
                                .padding(4)
                        }
                    }
                }
            }
            .padding(.vertical, 8)
        }
    }
}
