//
//  FoodListService.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import Foundation
import Combine
import UIKit

final class FoodListService: FoodListServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchList() -> AnyPublisher<FoodModelWrapper, NetworkError> {
        
        return networkService.request(
            type: FoodModelWrapper.self, endpoint: AppConstants.Api.fetchFood,
            method: .get,
            queryItems: nil,
            body: nil,
            headers: nil
        )
    }
    
    func updateFoodList(body: AddFoodRequest) -> AnyPublisher<AddFoodResponseModelWrapper, NetworkError> {
        let formData: [String: Any] = [
            "name": body.name ?? "",
            "description": body.description ?? "",
            "category_id": body.categoryId ?? 0,
            "calories": body.calories ?? "",
            "tags.0": body.tag_0 ?? [],
            "tags.1": body.tag_1 ?? []
        ]
        
        var files: [(name: String, filename: String, data: Data, mimeType: String)] = []
        
        if let images0 = body.images_0 as? [UIImage] {
            for (index, image) in images0.enumerated() {
                if let imageData = image.jpegData(compressionQuality: 0.5) {
                    let filename = "image_\(index).jpg"
                    files.append((name: "images.0", filename: filename, data: imageData, mimeType: "image/jpeg"))
                }
            }
        }

        if let images1 = body.images_1 as? [UIImage] {
            for (index, image) in images1.enumerated() {
                if let imageData = image.jpegData(compressionQuality: 0.5) {
                    let filename = "image_\(index).jpg"
                    files.append((name: "images.1", filename: filename, data: imageData, mimeType: "image/jpeg"))
                }
            }
        }
        
        return networkService.requestMultipart(
            type: AddFoodResponseModelWrapper.self,
            endpoint: AppConstants.Api.postFoodToServer,
            method: .post,
            formData: formData,
            files: files
        )
    }
    
    
}
