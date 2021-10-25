//
//  Model.swift
//  Build3D Portal
//
//  Created by Skye Parker on 10/12/21.
//

import SwiftUI
import RealityKit
import Combine

enum ModelCategory: CaseIterable {
    case toy
    case misc
    case decor
    case light
    
    var label: String {
        get {
            switch self {
            case .toy:
                return "Toys"
            case .misc:
                return "Misc"
            case .decor:
                return "Decor"
            case .light:
                return "Lights"
            }
        }
    }
}


class Model {
    var name: String
    var category: ModelCategory
    var thumbnail: UIImage
    var modelEntity: ModelEntity?
    var scaleCompensation: Float
    
    private var cancellable: AnyCancellable?
    
    init(name: String, category: ModelCategory, scaleCompensation: Float = 1.0) {
        self.name = name
        self.category = category
        self.thumbnail = UIImage(named: name) ?? UIImage(systemName: "photo")!
        self.scaleCompensation = scaleCompensation
    }
    
    func asyncLoadModelEntity() {
        let filename = self.name + ".usdz"
        
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { loadCompletion in
                
                switch loadCompletion {
                case .failure(let error): print("Unable to load modelEntity for \(filename). Error: \(error.localizedDescription)")
                case .finished:
                    break
                }
                
            }, receiveValue: { modelEntity in
                
                self.modelEntity = modelEntity
                self.modelEntity?.scale *= self.scaleCompensation
                
                print("modelEntity for \(self.name) has been loaded.")
                
            })
    }
}

struct Models {
    var all: [Model] = []
    
    init() {
        //Toys
        let toyBiplane = Model(name: "toy_biplane", category: .toy, scaleCompensation: 0.32/100)
        let toyRobotVintage = Model(name: "toy_robot_vintage", category: .toy, scaleCompensation: 0.32/100)
        
        self.all += [toyBiplane, toyRobotVintage]
        
        //Misc
        let tvRetro = Model(name: "tv_retro", category: .misc, scaleCompensation: 0.32/100)
        let wateringcan = Model(name: "wateringcan", category: .misc, scaleCompensation: 0.32/100)
        
        self.all += [tvRetro, wateringcan]
        
        //Decor
        
        //Lights
    }
    
    func get(category: ModelCategory) -> [Model] {
        return all.filter( {$0.category == category} )
    }
}
