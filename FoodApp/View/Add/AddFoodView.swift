//
//  AddFoodView.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import SwiftUI

struct AddFoodView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel: FoodListViewModel
    
    init(viewModel: FoodListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationHeaderView(title: "Add new food") {
                presentationMode.wrappedValue.dismiss()
            }
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ImageUploadSectionView(
                        onTakePhoto: viewModel.takePhoto,
                        onUpload: viewModel.uploadPhoto
                    )
                    
                    if !viewModel.selectedImages.isEmpty {
                        SelectedImagesView(
                            images: viewModel.selectedImages,
                            onDelete: viewModel.removeImage
                        )
                    }
                    
                    FormFieldsView(viewModel: viewModel)
                    
                    AddButtonView(action: viewModel.addFood)
                }
                .padding()
            }
        }
        .background(Color(.systemBackground))
        .sheet(isPresented: $viewModel.showCameraPicker) {
            CameraView { image in
                viewModel.addImageFromCamera(image)
            }
        }
        .sheet(isPresented: $viewModel.showImagePicker) {
            PhotoLibraryPicker(
                onImagesSelected: { images in
                    viewModel.addImagesFromLibrary(images)
                },
                maxSelections: 3 - viewModel.selectedImages.count
            )
        }
        .alert(item: $viewModel.errorMessage) { errorMessage in
            Alert(
                title: Text("Error"),
                message: Text(errorMessage.message),
                dismissButton: .default(Text("OK"))
            )
        }
        .alert(item: $viewModel.successMessage) { successMessage in
            Alert(
                title: Text("Success"),
                message: Text(successMessage.message),
                dismissButton: .default(Text("OK")) {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
        .overlay(
            Group {
                if viewModel.isLoading {
                    Color.black.opacity(0.3)
                        .edgesIgnoringSafeArea(.all)
                        .overlay(
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle())
                                .scaleEffect(1.5)
                                .foregroundColor(.white)
                        )
                }
            }
        )
    }
}
