//
//  PreferencesTableView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/31/23.
//

import AppKit
import SnapKit
import Combine

enum PreferencesCellList: CaseIterable {
    case requestAccessView
    case storage
    case cpu
    case my
    
    var height: CGFloat {
        switch self {
        case .requestAccessView:
            return 100.0
        case .storage:
            return 300.0
        case .cpu:
            return 40.0
        case .my:
            return 50.0
        }
    }
}

class PreferencesTableView: NSTableView {
    let requestAccessView = RequestAccessView()
    let storageView = StorageView()
    
    func setup() {
        self.delegate = self
        self.dataSource = self
        
        let column1 = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("Preferences"))
        column1.width = 100.0
        column1.title = "Preferences"
        self.addTableColumn(column1)
        
        self.selectionHighlightStyle = .none
    }
    
}

extension PreferencesTableView: NSTableViewDelegate, NSTableViewDataSource {
    func getCellForRow(at row: Int) -> NSView {
        let allCases = PreferencesCellList.allCases
        if row >= 0 && row < allCases.count {
            switch allCases[row] {
            case .requestAccessView:
                return requestAccessView
            case .storage:
                return StorageView()
            case .cpu:
                // Return the view for the CPU cell
                return NSView() // Placeholder
            case .my:
                // Return the view for the "my" cell
                return NSView() // Placeholder
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
