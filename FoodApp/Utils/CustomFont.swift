//
//  CustomFont.swift
//  FoodApp
//
//  Created by Sharon Omoyeni Babatunde on 26/02/2025.
//

import SwiftUI

enum CustomFont: String {
    case satoshiRegular = "Satoshi-Regular"
    case satoshiBold = "Satoshi-Bold"
    case satoshiMedium = "Satoshi-Medium"
    
    func font(size: CGFloat, weight: Font.Weight? = nil) -> Font {
           let fontWeight: Font.Weight
           
           switch weight {
           case .some(.heavy):
               fontWeight = .heavy
           case .some(.bold):
               fontWeight = .bold
           case .some(.semibold):
               fontWeight = .semibold
           case .some(.medium):
               fontWeight = .medium
           case .some(.light):
               fontWeight = .light
           default:
               fontWeight = .regular
           }
           
           return Font.custom(self.rawValue, size: size).weight(fontWeight)
       }
}

