//
//  PreferencesTableView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/31/23.
//

import AppKit
import SnapKit
import Combine

enum PreferencesCellList: Int, CaseIterable {
    case requestAccessView = 1
    case cpu = 2
    case my = 3
    
    var height: CGFloat {
        switch self {
        case .requestAccessView:
            return 60.0
        case .cpu:
            return 40.0
        case .my:
            return 50.0
        }
    }
}

class PreferencesTableView: NSTableView {
    let requestAccessView = RequestAccessView()
    
    func setup() {
        self.delegate = self
        self.dataSource = self
        
        let column1 = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("Preferences"))
        column1.width = 100.0
        column1.title = "Preferences"
        self.addTableColumn(column1)
    }
    
}

extension PreferencesTableView: NSTableViewDelegate, NSTableViewDataSource {
    func getCellForRow(at row: Int) -> NSView {
        let allCases = PreferencesCellList.allCases
        if row >= 0 && row < allCases.count {
            switch allCases[row] {
            case .requestAccessView:
                return requestAccessView
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
