//
//  MenubarView.swift
//  Box42
//
//  Created by Chan on 2023/03/16.
//

import Foundation
import AppKit

class MenuBarView {
    
    func buttonAppear(_ statusBar: StatusBar) {
        let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        statusBar.statusItem = statusItem
    }
    
    func imageChange(_ imgName: String, _ statusBar: StatusBar) {
        statusBar.frames.removeAll()
        switch imgName {
        case "cat": for i in (0...4) {statusBar.frames.append(NSImage(imageLiteralResourceName: "cat_page\(i)"))}
        case "gon": for i in (1...5) {statusBar.frames.append(NSImage(imageLiteralResourceName: "gon_\(i)"))}
        case "gun": for i in (1...5) {statusBar.frames.append(NSImage(imageLiteralResourceName: "gun_\(i)"))}
        case "lee": for i in (1...5) {statusBar.frames.append(NSImage(imageLiteralResourceName: "lee_\(i)"))}
        case "gam": for i in (1...5) {statusBar.frames.append(NSImage(imageLiteralResourceName: "gam_\(i)"))}
        case "box": for i in (1...4) {statusBar.frames.append(NSImage(imageLiteralResourceName: "42box_\(i)"))}
        case "box_oc": for i in (1...2) {statusBar.frames.append(NSImage(imageLiteralResourceName: "42box_oc\(i)"))}
        default : for i in (1...11) {statusBar.frames.append(NSImage(imageLiteralResourceName: "42flip_0\(i)"))}
        }
    }
}
