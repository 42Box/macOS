//
//  QuickSlotViewController.swift
//  Box42
//
//  Created by Chanhee Kim on 8/25/23.
//

import AppKit

class QuickSlotViewController: NSViewController {
    var viewModel: QuickSlotViewModel!
    
    override func loadView() {
        super.viewDidLoad()
        let quickSlotViewGroup = QuickSlotGroupView()
        quickSlotViewGroup.quickslotAction = quickslotAction

        self.view = quickSlotViewGroup
    }
    
    func setupHeader() {
        // headerLabel을 뷰에 추가하고 레이아웃을 설정합니다.
    }
    
    func setupGroupView() {
        // groupView를 뷰에 추가하고 레이아웃을 설정합니다.
    }
    
    func setupButtons() {
        // 4x2 버튼을 groupView에 추가하고 레이아웃을 설정합니다.
    }
    
    @objc func buttonTapped(sender: NSButton) {
        // 버튼이 눌렸을 때의 처리
    }
    
    func quickslotAction() {
        print("quick slot")
    }
}
