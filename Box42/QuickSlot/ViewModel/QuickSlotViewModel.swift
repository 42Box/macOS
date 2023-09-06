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
        let button1 = QuickSlotButtonModel(scriptUuid: UUID(uuidString: "37a56076-e72c-4efe-ba7f-de0effe7f4c3f"),
                                           title: QuickSlotUI.title.clean,
                                           path: Bundle.main.path(forResource: "CleanCache_cluster", ofType: "sh"),
                                           type: "sh"
        )
        let button2 = QuickSlotButtonModel(title: QuickSlotUI.title.preferences,
                                           path: "default-preferences",
                                           type: "default-pref")
        let button3 = QuickSlotButtonModel(title: QuickSlotUI.title.scripts,
                                           path: "default-scripts",
                                           type: "default-sh")
        let button4 = QuickSlotButtonModel(title: QuickSlotUI.title.user,
                                           path: "default-user",
                                           type: "default-pref")
        
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
        if let index = buttons.firstIndex(where: { $0.scriptUuid == id }) {
            let buttonToRemove = buttons[index]
            if let type = buttonToRemove.type, !type.hasPrefix("default") {
                buttons.remove(at: index)
                updateMeQuickSlot()
            }
        }
    }
    
    func removeButton(_ path: String) {
        print("1. Attempting to remove button with path: \(path)")
        print("2. Current buttons: \(buttons)")
        if let index = buttons.firstIndex(where: { $0.path == path }) {
            print("3. Found button at index: \(index)")
            let buttonToRemove = buttons[index]
            print("4. Button to remove: \(buttonToRemove)")
            if let type = buttonToRemove.type {
                print("5. Button type: \(type)")
                if !type.hasPrefix("default") {
                    print("6. Removing button...")
                    buttons.remove(at: index)
                    updateMeQuickSlot()
                } else {
                    print("Button type starts with 'default'. Skipping removal.")
                }
            } else {
                print("Button type is nil. Skipping removal.")
            }
        } else {
            print("Button not found.")
        }
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

