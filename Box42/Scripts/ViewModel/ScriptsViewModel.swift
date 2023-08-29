//
//  ScriptViewModel.swift
//  Box42
//
//  Created by Chanhee Kim on 8/28/23.
//

import AppKit
import Combine

class ScriptViewModel: NSObject {
    @Published var scripts: [Script] = []
    
    override init() {
        self.scripts = [
            Script(name: "cleanCache", description: "Cleaning cache"),
            Script(name: "brewInGoinfre", description: "Brew download in goinfre")
        ]
    }
    
    // Create
    func addScript(name: String, description: String) {
        let newScript = Script(name: name, description: description)
        scripts.append(newScript)
    }
    
    // Read
    func excuteScript(id: UUID) {
        if let index = scripts.firstIndex(where: { $0.id == id }) {
            ExcuteScripts.executeShellScript(path: scripts[index].name)
        }
    }
    
    // Update
    func updateScript(id: UUID, newName: String, newDescription: String) {
        if let index = scripts.firstIndex(where: { $0.id == id }) {
            scripts[index].name = newName
            scripts[index].description = newDescription
        }
    }
    
    // Delete
    func deleteScript(id: UUID) {
        scripts.removeAll(where: { $0.id == id })
        QuickSlotViewModel.shared.removeButton(id)
    }
    
    func quickSlotScript(id: UUID) {
        if let index = scripts.firstIndex(where: { $0.id == id }) {
            let button = QuickSlotButtonModel(id: id, title: scripts[index].name)
            QuickSlotViewModel.shared.addButton(button)
        }
    }
    
}
