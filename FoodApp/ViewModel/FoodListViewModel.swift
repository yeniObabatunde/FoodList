//
//  AddFoodViewModel.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import SwiftUI
import Combine

struct ErrorMessage: Identifiable {
    let id = UUID()
    var message: String
}

struct SuccessMessage: Identifiable {
    let id = UUID()
    let message: String
}


class FoodListViewModel: FoodListViewModelProtocol {
    
    var foodList: [FoodModelDatum] = []
    
    @Published var isLoading = false
    @Published var error: Error?
    @Published var errorMessage: ErrorMessage?
    @Published var showCameraPicker = false
    @Published var showImagePicker = false
    @Published var successMessage: SuccessMessage?
    @Published var foodName: String = ""
    @Published var foodDescription: String = ""
    @Published var selectedCategory: String = "Dawn Delicacies"
    @Published var searchText: String = ""
    @Published var calories: String = ""
    @Published var tagInput: String = ""
    @Published var tags: [String] = []
    @Published var selectedImages: [UIImage] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let serviceDI: ServiceDIContainerProtocol
    
    var filteredFoodList: [FoodModelDatum] {
        if searchText.isEmpty {
            return foodList
        } else {
            return foodList.filter { $0.name?.localizedCaseInsensitiveContains(searchText) ?? false }
        }
    }
    
    init(serviceDI: ServiceDIContainerProtocol) {
        self.serviceDI = serviceDI
    }
    
    let categories = ["Morning Feast", "Sunrise Meal", "Dawn Delicacies"]
    
    func loadFoodList() {
        guard !isLoading else {
            return
        }
        isLoading = true
        error = nil
        
        serviceDI.characterService.fetchList()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.isLoading = false
                    self.error = error
                    self.errorMessage = ErrorMessage(message: error.localizedDescription)
                }
            } receiveValue: { [weak self] newCharacters in
                guard let self = self else { return }
                let newResults = newCharacters.data?.reversed() ?? []
                self.foodList = newResults
                self.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    func takePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.showCameraPicker = true
            self.showImagePicker = false
        } else {
            self.errorMessage = ErrorMessage(message: "Camera is not available on this device")
        }
        print("Take photo action")
    }
    
    func uploadPhoto() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            self.showImagePicker = true
            self.showCameraPicker = false
        } else {
            self.errorMessage = ErrorMessage(message: "Camera is not available on this device")
        }
    }
    
    func addImageFromCamera(_ image: UIImage) {
        if self.selectedImages.count < 3 {
            self.selectedImages.append(image)
        }
    }
    
    func addImagesFromLibrary(_ images: [UIImage]) {
        let availableSlots = 3 - self.selectedImages.count
        if availableSlots > 0 {
            let newImages = Array(images.prefix(availableSlots))
            self.selectedImages.append(contentsOf: newImages)
        }
    }
    
    func removeImage(at index: Int) {
        guard index < selectedImages.count else { return }
        selectedImages.remove(at: index)
    }
    
    func getBase64EncodedImages() -> [String] {
        return selectedImages.compactMap { $0.toBase64() }
    }
    
    func addTag() {
        let trimmedInput = tagInput.trimmingCharacters(in: .whitespacesAndNewlines)
        if !trimmedInput.isEmpty && !tags.contains(trimmedInput) {
            tags.append(trimmedInput)
            tagInput = ""
        }
    }
    
    func generateTagID() -> Int {
        return Int.random(in: 1...9)
    }
    
    func addFood() {
        
        guard !foodDescription.isEmpty, !foodName.isEmpty, !calories.isEmpty, !selectedCategory.isEmpty, !tagInput.isEmpty, !tags.isEmpty, !selectedImages.isEmpty else {
            self.errorMessage = ErrorMessage(message: "Please fill in the required fields")
            return
        }
        
        let base64Images = getBase64EncodedImages()
        let foodData = AddFoodRequest(name: foodName, description: foodDescription, categoryId: generateTagID(), calories: Int(calories), tag_1: [tags.count], tag_0: [generateTagID()], images_0: base64Images, images_1: base64Images)
        isLoading = true
        error = nil
        
        Logger.printIfDebug(data: "\(foodData)", logType: .info)
        
        serviceDI.characterService.updateFoodList(body: foodData)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.isLoading = false
                    self.error = error
                    self.errorMessage = ErrorMessage(message: error.localizedDescription)
                }
            } receiveValue: { [weak self] newCharacters in
                guard let self = self else { return }
                self.isLoading = false
                self.successMessage = SuccessMessage(message: newCharacters.message ?? "Food added successfully!")
                self.resetForm()
            }
            .store(in: &cancellables)
    }
    
    private func resetForm() {
        foodName = ""
        foodDescription = ""
        selectedCategory = "Dawn Delicacies"
        calories = ""
        tagInput = ""
        tags = []
        selectedImages = []
    }
}
