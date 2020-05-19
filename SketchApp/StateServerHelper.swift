//
//  StateServer.swift
//  SketchApp
//
//  Created by Havil on 13.05.2020.
//  Copyright © 2020 Havil. All rights reserved.
//

import Foundation

class StateServerHelper {
    
    struct State: Codable {
        let power: Bool
    }
    
    func getState(data: Data) -> State {
        let state = try! JSONDecoder().decode(State.self, from: data)
        return state
    }
    
}
