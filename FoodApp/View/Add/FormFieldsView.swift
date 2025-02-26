//
//  FormFieldsView.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import SwiftUI

struct FormFieldsView: View {
    @ObservedObject var viewModel: FoodListViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            FormFieldView(title: "Name") {
                TextField("Enter food name", text: $viewModel.foodName)
                    .padding()
                    .frame(height: 50)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
            }
            FormFieldView(title: "Description") {
                TextEditorFieldView(
                    text: $viewModel.foodDescription,
                    placeholder: "Enter food description"
                )
            }
            FormFieldView(title: "Category") {
                CategoryPickerView(
                    selectedCategory: $viewModel.selectedCategory,
                    categories: viewModel.categories
                )
            }
            FormFieldView(title: "Calories") {
                TextField("Enter number of calories", text: $viewModel.calories)
                    .keyboardType(.numberPad)
                    .padding()
                    .frame(height: 50)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
            }
            FormFieldView(title: "Tags") {
                TagsEditorView(
                    tags: $viewModel.tags,
                    tagInput: $viewModel.tagInput,
                    onAddTag: viewModel.addTag
                )
            }
        }
    }
}
