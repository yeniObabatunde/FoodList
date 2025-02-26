//
//  FoodItem.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import Foundation

// MARK: - Models and Enums
struct FoodItem {
    let title: String
    let calories: Int
    let description: String
    let tags: [String]
    let imageName: String
    var isFavorite: Bool
}

enum FoodCategory: CaseIterable {
    case all
    case morningFeast
    case sunriseMeal
    case dawnDelicacies
    
    var displayName: String {
        switch self {
        case .all: return "All"
        case .morningFeast: return "Morning Feast"
        case .sunriseMeal: return "Sunrise Meal"
        case .dawnDelicacies: return "Dawn Delicacies"
        }
    }
}


struct FoodModelWrapper: Codable {
    let status, message: String?
    let data: [FoodModelDatum]?
}

// MARK: - Datum
struct FoodModelDatum: Codable, Identifiable, Hashable {
    let id: Int?
    let name, description: String?
    let categoryID, calories: Int?
    let createdAt, updatedAt: String?
    let foodTags: [String]?
    let foodImages: [FoodImage]?
    let category: Category?
    var isFavorite: Bool?
    
    var imageURL: [URL]? {
        foodImages?.compactMap { URL(string: $0.imageURL ?? "") }
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case categoryID = "category_id"
        case calories
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case foodTags, foodImages, category
    }
}

// MARK: - Category
struct Category: Codable, Identifiable, Hashable {
    let id: Int?
    let name, description: String?
    let createdAt, updatedAt: AtedAt?

    enum CodingKeys: String, CodingKey {
        case id, name, description
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

enum AtedAt: String, Codable {
    case the20250215T081556000000Z = "2025-02-15T08:15:56.000000Z"
}

// MARK: - FoodImage
struct FoodImage: Codable, Identifiable, Hashable {
    let id: Int?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "image_url"
    }
}
