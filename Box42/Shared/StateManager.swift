//
//  StateManager.swift
//  Box42
//
//  Created by Chanhee Kim on 8/8/23.
//

class StateManager {
    static let shared = StateManager()

    private var isPin: Bool!
    private var isShowCPUUsage: Bool!
    private var isShowWindow: Bool!
    private var isShowFirstWindow: Bool!
    private var isAutoStorage: Bool!
    
    private init() {
        isPin = false
        isShowCPUUsage = false
        isShowWindow = false
        isShowFirstWindow = false
        isAutoStorage = true
    }
    
    func getIsPin() -> Bool {
        return isPin
    }

    func setToggleIsPin() {
        isPin.toggle()
    }
    
    func getIsShowCPUUsage() -> Bool {
        return isShowCPUUsage
    }
    
    func setToggleIsShowCPUUsage() {
        isShowCPUUsage.toggle()
    }
    
    func getIsShowWindow() -> Bool {
        return isShowWindow
    }
    
    func setToggleIsShowWindow() {
        isShowWindow.toggle()
    }
    
    func getIsShowFirstWindow() -> Bool {
        return isShowFirstWindow
    }
    
    func setToggleIsShowFirstWindow() {
        isShowFirstWindow.toggle()
    }
    
    func getIsAutoStorage() -> Bool {
        return isAutoStorage
    }
    
    func setOffIsAutoStorage() {
        isAutoStorage = false
    }
    
    func setOnIsAutoStorage() {
        isAutoStorage = true
    }
}
