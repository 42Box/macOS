//
//  QuickSlotTableView.swift
//  Box42
//
//  Created by Chanhee Kim on 9/3/23.
//

import AppKit
import SnapKit
import Combine

class QuickSlotTableView: NSTableView {
    var viewModel: QuickSlotViewModel? {
        didSet {
            print("ViewModel has been set.")
            setupBindings()
        }
    }

    var cancellables: Set<AnyCancellable> = []
    
    private func setupBindings() {
        print("Setting up QuickSlotTableView...") // 디버깅 로그
        viewModel?.$buttons.sink(receiveValue: { [weak self] newScripts in
            print("Received new QuickSlotTableViewModel: \(newScripts)") // 디버깅 로그
            DispatchQueue.main.async {
                self?.reloadData()
            }
        }).store(in: &cancellables)
    }
    
    func setup() {
        self.delegate = self
        self.dataSource = self
        
        let column1 = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("QuickSlots"))
        column1.width = 100.0
        column1.title = "QuickSlot"
        self.addTableColumn(column1)
    }
}

extension QuickSlotTableView: NSTableViewDelegate, NSTableViewDataSource {
    func getCellForRow(at row: Int) -> NSView {
        guard let viewModel = viewModel else {
            return NSView()
        }
        
        if row < viewModel.buttons.count {
            return getQuickSlotCell(for: viewModel.buttons[row], viewModel: viewModel)
        } else {
            return getQuickSlotCellManager()
        }
    }

    private func getQuickSlotCell(for quickSlotItem: QuickSlotButtonModel, viewModel: QuickSlotViewModel) -> QuickSlotCell {
        let cell = QuickSlotCell(frame: .zero)
        cell.configure(with: quickSlotItem, viewModel: viewModel)
        return cell
    }

    private func getQuickSlotCellManager() -> QuickSlotCellManager {
        let quickSlotCellManger = QuickSlotCellManager(frame: .zero)
        return quickSlotCellManger
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return (viewModel?.buttons.count ?? 0 ) // + 1
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        getCellForRow(at: row)
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 200
    }
}
