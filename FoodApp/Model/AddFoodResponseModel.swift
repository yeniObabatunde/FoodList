//
//  AddFoodResponseModel.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 26/02/2025.
//

import Foundation

struct AddFoodResponseModelWrapper: Codable {
    let status, message: String?
    let data: AddFoodResponseModel?
}

// MARK: - DataClass
struct AddFoodResponseModel: Codable {
    let id: Int?
    let name, description: String?
    let categoryID, calories: Int?
    let createdAt, updatedAt: String?
    let foodTags: [String]?
    let foodImages: [FoodImage]?
    let category: Category?

    enum CodingKeys: String, CodingKey {
        case id, name, description
        case categoryID = "category_id"
        case calories
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case foodTags, foodImages, category
    }
}
