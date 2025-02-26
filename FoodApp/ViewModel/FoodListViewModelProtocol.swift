//
//  FoodListViewModelProtocol.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import Foundation
import Combine

protocol FoodListViewModelProtocol: ObservableObject {
    var foodList: [FoodModelDatum] { get }
    var filteredFoodList: [FoodModelDatum] { get }
    var isLoading: Bool { get }
    var error: Error? { get }
    var errorMessage: ErrorMessage? { get }
    var successMessage: SuccessMessage? { get }
    
    func loadFoodList()
    func takePhoto()
    func uploadPhoto()
    func removeImage(at index: Int)
    func addTag()
}

protocol CharacterServiceProtocol {
    func postFoodToServer()
    func fetchFoodList() -> AnyPublisher<FoodModelWrapper, NetworkError>
}

