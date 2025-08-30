//
//  LayoutConstants.swift
//  Zerodash
//
//  Created by CA on 31/08/25.
//


import SwiftUI

struct AppConstants {
    struct Layout {
        static let dashboardWidth: CGFloat = 980
        static let dashboardHeight: CGFloat = 660
        static let dashboardSize = CGSize(width: dashboardWidth, height: dashboardHeight)
        static let sidebarWidth: CGFloat = 80
        static let infoPanelWidth: CGFloat = 280
    }
    
    struct UI {
        static let cornerRadius: CGFloat = 16
        static let shadowRadius: CGFloat = 8
        static let animationDuration: Double = 0.3
    }
    
    struct Spacing {
        static let small: CGFloat = 8
        static let medium: CGFloat = 16
        static let large: CGFloat = 24
    }
}
