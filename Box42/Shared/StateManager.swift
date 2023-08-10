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
    
    private init() {
        isPin = false
        isShowCPUUsage = false
        isShowWindow = false
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
    
    func getToggleIsShowWindow() -> Bool {
        return isShowWindow
    }
    
    func setToggleIsShowWindow() {
        isShowWindow.toggle()
    }
}
