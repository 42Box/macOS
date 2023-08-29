//
//  QuickSlotViewModel.swift
//  Box42
//
//  Created by Chanhee Kim on 8/27/23.
//

import AppKit
import Combine

class QuickSlotViewModel {
    @Published var buttons: [QuickSlotButtonModel] = []
    
    init() {
        let button1 = QuickSlotButtonModel(title: QuickSlotUI.title.clean)
        let button2 = QuickSlotButtonModel(title: QuickSlotUI.title.preferences)
        let button3 = QuickSlotButtonModel(title: QuickSlotUI.title.scripts)
        let button4 = QuickSlotButtonModel(title: QuickSlotUI.title.user)
        
        buttons = [button1, button2, button3, button4]
    }

    func addButton(_ button: QuickSlotButtonModel) {
        buttons.append(button)
    }
    
    func removeButton(id: UUID) {
        buttons.removeAll { $0.id == id }
    }
    
    func updateButton(id: UUID, newTitle: String) {
        if let index = buttons.firstIndex(where: { $0.id == id }) {
            buttons[index].title = newTitle
        }
    }
}
