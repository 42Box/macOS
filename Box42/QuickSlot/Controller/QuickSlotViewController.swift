//
//  QuickSlotViewController.swift
//  Box42
//
//  Created by Chanhee Kim on 8/25/23.
//

import AppKit

class QuickSlotViewController: NSViewController {
    var viewModel: QuickSlotViewModel!
    var buttonCollectionView: QuickSlotButtonCollectionViewController!
    
    override func loadView() {
        let quickSlotViewGroup = QuickSlotGroupView()
        quickSlotViewGroup.headerAction = headerAction

        NotificationCenter.default.addObserver(self, selector: #selector(handleButtonTapped), name: .collectionButtonTapped, object: nil)
        
        self.view = quickSlotViewGroup
    }
    
    func headerAction() {
        print("quick slot header")
    }

    @objc func handleButtonTapped(notification: NSNotification) {
        if let button = notification.object as? NSButton {
            print("Button with title \(button.title) was tapped in QuickSlotView")
        }
    }
}
