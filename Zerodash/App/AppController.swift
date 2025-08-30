//
//  AppController.swift
//  Zerodash
//
//  Created by CA on 30/08/25.
//


import SwiftUI

@MainActor
final class AppController {
    static let shared = AppController()
    
    private let panelController = ZeroDashPanelController()
    private var toggleScheduled = false
    
    private init() {
        debugPrint("AppController", "Initialized")
    }
    
    func toggleDashboard(activateApp: Bool = false) {
        if toggleScheduled {
            debugPrint("AppController", "Toggle already scheduled, ignoring duplicate")
            return
        }
        
        toggleScheduled = true
        debugPrint("AppController", "Scheduling dashboard toggle")
        
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            debugPrint("AppController", "Executing dashboard toggle with DashboardRoot")
            self.panelController.toggle(
                content: DashboardRoot(),
                size: CGSize(width: 860, height: 620),
                centerOnFirstShow: true,
                activateApp: activateApp
            )
            self.toggleScheduled = false
        }
    }
    
    func showDashboard(activateApp: Bool = false) {
        debugPrint("AppController", "Showing dashboard explicitly")
        panelController.show(
            content: DashboardRoot(),
            size: CGSize(width: 860, height: 620),
            centerOnFirstShow: true,
            activateApp: activateApp
        )
    }
    
    func hideDashboard() {
        debugPrint("AppController", "Hiding dashboard explicitly")
        panelController.hide()
    }
}
