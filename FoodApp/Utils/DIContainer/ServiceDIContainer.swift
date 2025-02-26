//
//  ServiceDIContainer.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import Foundation

final class ServiceDIContainer: ServiceDIContainerProtocol {
    
    static let shared = ServiceDIContainer()
    
    lazy var characterService: FoodListServiceProtocol = {
        let networkService = NetworkService(baseURL: AppConstants.Api.baseUrlString ?? "")
        return FoodListService(networkService: networkService)
    }()
    
    private init() {}
}
