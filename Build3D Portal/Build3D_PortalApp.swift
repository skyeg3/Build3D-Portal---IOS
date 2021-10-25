//
//  Build3D_PortalApp.swift
//  Build3D Portal
//
//  Created by Skye Parker on 10/10/21.
//

import SwiftUI

@main
struct Build3D_PortalApp: App {
    @StateObject var placementSettings = PlacementSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(placementSettings)
        }
    }
}
