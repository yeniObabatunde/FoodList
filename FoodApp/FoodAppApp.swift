//
//  FoodAppApp.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 25/02/2025.
//

import SwiftUI
import IQKeyboardManagerSwift

@main
struct FoodAppApp: App {
    
    init() {
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
