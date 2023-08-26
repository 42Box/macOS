//
//  QuickSlotViewModel.swift
//  Box42
//
//  Created by Chanhee Kim on 8/27/23.
//

import AppKit

// ViewModel
class QuickSlotViewModel {
    var buttons: [QuickSlotButtonModel] = [
        // 초기 버튼 데이터
    ]
    
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
