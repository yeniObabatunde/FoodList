//
//  AppConstants.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import Foundation

enum AppConstants {
    
  enum Api {
      static let baseUrlString = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String
      static let fetchFood = "/api/foods"
      static let postFoodToServer = "/api/foods/5"
    }
}
