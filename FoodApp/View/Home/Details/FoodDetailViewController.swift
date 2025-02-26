//
//  FoodDetailViewController.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 26/02/2025.
//

import UIKit

class FoodDetailViewController: UIViewController {
    
    private let foodDetailView = FoodDetailView()
    private let food: FoodModelDatum
    private let onDismiss: (() -> Void)?
    
    init(food: FoodModelDatum, onDismiss: (() -> Void)? = nil) {
        self.food = food
        self.onDismiss = onDismiss
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = foodDetailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Food Details"
        foodDetailView.configure(with: food)
        setupViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        if let window = view.window {
            view.frame = window.bounds
        }
    }
    
    private func setupViewController() {
        foodDetailView.onBackButtonTapped = { [weak self] in
            self?.onDismiss?()
            self?.navigationController?.popViewController(animated: true)
        }
    }
}
