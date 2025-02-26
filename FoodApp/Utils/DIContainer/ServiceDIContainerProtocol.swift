//
//  ServiceDIContainerProtocol.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import Foundation
import Combine

protocol ServiceDIContainerProtocol {
    var characterService: FoodListServiceProtocol { get }
}

protocol FoodListServiceProtocol {
    func fetchList() -> AnyPublisher<FoodModelWrapper, NetworkError>
    func updateFoodList(body: AddFoodRequest) -> AnyPublisher<AddFoodResponseModelWrapper, NetworkError>
}

