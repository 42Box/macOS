//
//  QuickSlotViewModel.swift
//  Box42
//
//  Created by Chanhee Kim on 8/27/23.
//

import AppKit
import Combine

class QuickSlotViewModel {
    static let shared = QuickSlotViewModel()
    @Published var buttons: [QuickSlotButtonModel] = []
    
    private init() {
        let button1 = QuickSlotButtonModel(id: UUID(uuidString: "550e8400-e29b-41d4-a716-446655440000")!,
                                           title: QuickSlotUI.title.clean,
                                           path: Bundle.main.path(forResource: "cleanCache", ofType: "sh"))
        let button2 = QuickSlotButtonModel(title: QuickSlotUI.title.preferences)
        let button3 = QuickSlotButtonModel(title: QuickSlotUI.title.scripts)
        let button4 = QuickSlotButtonModel(title: QuickSlotUI.title.user)
        
        buttons = [button1, button2, button3, button4]
    }
    
    // 퀵슬롯 안에 해당 버튼이 없으면 추가
    func addButton(_ button: QuickSlotButtonModel) {
        if !buttons.contains(where: { $0.id == button.id }) {
            buttons.append(button)
        }
    }
    
    func removeButton(_ id: UUID) {
        buttons.removeAll { $0.id == id }
    }
    
    func updateButton(id: UUID, newTitle: String) {
        if let index = buttons.firstIndex(where: { $0.id == id }) {
            buttons[index].title = newTitle
        }
    }
}
