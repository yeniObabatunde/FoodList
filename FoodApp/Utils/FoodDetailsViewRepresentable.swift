//
//  FoodDetailsViewRepresentable.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 26/02/2025.
//

import SwiftUI

struct FoodDetailsViewRepresentable: UIViewControllerRepresentable {
    let food: FoodModelDatum
    @Environment(\.presentationMode) var presentationMode
    
    func makeUIViewController(context: Context) -> FoodDetailViewController {
        let viewController = FoodDetailViewController(food: food) {
            presentationMode.wrappedValue.dismiss()
        }
        viewController.modalPresentationStyle = .overFullScreen
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: FoodDetailViewController, context: Context) {
        uiViewController.view.frame = UIScreen.main.bounds
    }
}
