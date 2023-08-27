//
//  StateManager.swift
//  Box42
//
//  Created by Chanhee Kim on 8/8/23.
//

class StateManager {
    static let shared = StateManager()
    
    private var _pin: Bool = false
    private var _showCPUUsage: Bool = false
    private var _showWindow: Bool = false
    private var _showFirstWindow: Bool = false
    private var _autoStorage: Bool = true
    
    var pin: Bool {
        get { return _pin }
        set { _pin = newValue }
    }

    func togglePin() {
        _pin.toggle()
    }
    
    var showCPUUsage: Bool {
        get { return _showCPUUsage }
        set { _showCPUUsage = newValue }
    }

    func toggleShowCPUUsage() {
        _showCPUUsage.toggle()
    }
    
    var showWindow: Bool {
        get { return _showWindow }
        set { _showWindow = newValue }
    }
    
    func toggleShowWindow() {
        _showWindow.toggle()
    }
    
    var showFirstWindow: Bool {
        get { return _showFirstWindow }
        set { _showFirstWindow = newValue }
    }

    func toggleShowFirstWindow() {
        _showFirstWindow.toggle()
    }
    
    var autoStorage: Bool {
        get { return _autoStorage }
        set { _autoStorage = newValue }
    }
    
    func setOffAutoStorage() {
        _autoStorage = false
    }
    
    func setOnAutoStorage() {
        _autoStorage = true
    }
}
