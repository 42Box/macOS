//
//  PreferencesTableView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/31/23.
//

import AppKit
import SnapKit

enum PreferencesCellList: CaseIterable {
    case notifiactionSetting
    case shortcutSetting
    case iconSetting
    case requestAccess
    case storage
    case cpu
    case memory
    case battery
    case network
    
    var height: CGFloat {
        switch self {
        case .notifiactionSetting:
            return 120
        case .shortcutSetting:
            return 220
        case .iconSetting:
            return 150
        case .requestAccess:
            return 200
        case .storage:
            return 210.0
        case .cpu:
            return 150
        case .memory:
            return 160
        case .battery:
            return 140
        case .network:
            return 130
        }
    }
}

class PreferencesTableView: NSTableView {
    let notifiactionSettingView = NotificationSettingView()
    let shortcutSettingView = ShortcutSettingView()
    let iconSettingView = IconSettingView()
    let requestAccessView = RequestAccessView()
    let storageView = StorageView()
    let cpuView = CPUView()
    let memoryView = MemoryView()
    let batteryView = BatteryView()
    let networkView = NetworkView()
    
    func setup() {
        self.delegate = self
        self.dataSource = self
        
        let column1 = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("Preferences"))
        column1.width = 100.0
        column1.title = "Preferences"
        self.addTableColumn(column1)
        
//        self.selectionHighlightStyle = .none
    }
    
}

extension PreferencesTableView: NSTableViewDelegate, NSTableViewDataSource {
    func getCellForRow(at row: Int) -> NSView {
        let allCases = PreferencesCellList.allCases
        if row >= 0 && row < allCases.count {
            switch allCases[row] {
            case .notifiactionSetting:
                return notifiactionSettingView
            case .shortcutSetting:
                return shortcutSettingView
            case .iconSetting:
                return iconSettingView
            case .requestAccess:
                return requestAccessView
            case .storage:
                return storageView
            case .cpu:
                return cpuView
            case .memory:
                return memoryView
            case .battery:
                return batteryView
            case .network:
                return networkView
            }
        }
        return NSView() // Default view if out of bounds or undefined
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return PreferencesCellList.allCases.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        return getCellForRow(at: row)
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        let allCases = PreferencesCellList.allCases
        if row >= 0 && row < allCases.count {
            return allCases[row].height
        }
        
        return 44.0 // Default height
    }
}