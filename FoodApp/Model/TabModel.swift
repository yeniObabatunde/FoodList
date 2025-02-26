//
//  TabModel.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import Foundation

enum Tab: CaseIterable {
    case home
    case generator
    case add
    case favorite
    case planner
    
    var title: String {
        switch self {
        case .home: return "Home"
        case .generator: return "Generator"
        case .add: return "Add"
        case .favorite: return "Favourite"
        case .planner: return "Planner"
        }
    }
    
    var iconName: String {
        switch self {
        case .home: return "house.fill"
        case .generator: return "wand.and.stars"
        case .add: return "plus.circle"
        case .favorite: return "heart"
        case .planner: return "square.and.pencil"
        }
    }
}
