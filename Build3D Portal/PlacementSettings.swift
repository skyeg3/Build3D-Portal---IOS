//
//  PlacementSettings.swift
//  Build3D Portal
//
//  Created by Skye Parker on 10/17/21.
//

import SwiftUI
import RealityKit
import Combine

class PlacementSettings: ObservableObject {
    
    // When the user selects a model in Browseview, this property is set.
    @Published var selectedModel: Model? {
        willSet(newValue) {
            print("Setting selectedModel to \(String(describing: newValue?.name))")
        }
    }
    
    // When the user taps to confirm in PlacementView, the value of SelectedModel is assigned to confirmedModel.
    @Published var confirmedModel: Model? {
        willSet(newValue) {
            guard let model = newValue else {
                print("Clearing confirmedModel")
                return
            }
            
            print("Setting confirmedModel to \(model.name)")
        }
    }
    
    // This property retains the cancellable object for our SceneEvents.Update subscriber
    var sceneObserver: Cancellable?
    
}
