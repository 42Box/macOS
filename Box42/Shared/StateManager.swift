//
//  StateManager.swift
//  Box42
//
//  Created by Chanhee Kim on 8/8/23.
//

class StateManager {
    static let shared = StateManager()

    var isPin: Bool!
    
    private init() {
        isPin = false
    }
}
