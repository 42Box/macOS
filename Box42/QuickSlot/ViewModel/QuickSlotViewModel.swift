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
        let button1 = QuickSlotButtonModel(id: UUID(uuidString: "37a56076-e72c-4efe-ba7f-de0effe7f4c3")!,
                                           title: QuickSlotUI.title.clean,
                                           path: Bundle.main.path(forResource: "cleanCache", ofType: "sh"),
                                           type: "sh"
        )
        let button2 = QuickSlotButtonModel(title: QuickSlotUI.title.preferences, type: "pref")
        let button3 = QuickSlotButtonModel(title: QuickSlotUI.title.scripts)
        let button4 = QuickSlotButtonModel(title: QuickSlotUI.title.user, type: "pref")
        
        buttons = [button1, button2, button3, button4]
    }
    
    func setUpQuickSlot() {
        if let newButtons = UserManager.shared.userProfile?.quickSlotList {
            replaceQuickSlot(with: newButtons)
        }
    }
    
    // 새로운 스크립트 배열로 교체하는 메소드
    func replaceQuickSlot(with newQuickSlot: [QuickSlotButtonModel]) {
        self.buttons = newQuickSlot
    }
    
    // 퀵슬롯 안에 해당 버튼이 없으면 추가
    func addButton(_ button: QuickSlotButtonModel) {
        if !buttons.contains(where: { $0.scriptUuid == button.scriptUuid }) {
            buttons.append(button)
            updateMeQuickSlot()
        }
    }
    
    func removeButton(_ id: UUID) {
        buttons.removeAll { $0.scriptUuid == id }
        updateMeQuickSlot()
    }
    
    func updateButton(id: UUID, newTitle: String) {
        if let index = buttons.firstIndex(where: { $0.scriptUuid == id }) {
            buttons[index].title = newTitle
        }
    }
    
    func updateMeQuickSlot() {
        let body = QuickSlotModels(quickSlotList: buttons)
        API.putUserMeQuickSlot(quickSlots: body) { result in
            switch result {
            case .success(_):
                print("Successfully updated the scripts.") // 혹은 사용자에게 보여줄 알림 추가
            case .failure(let error):
                print("Failed to update scripts: \(error.localizedDescription)") // 혹은 사용자에게 보여줄 알림 추가
            }
        }
    }
}
