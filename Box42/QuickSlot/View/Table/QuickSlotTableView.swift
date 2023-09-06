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
    
        self.headerView = nil
        self.selectionHighlightStyle = .none
        
        let column1 = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("QuickSlots"))
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

    private func getQuickSlotCell(for quickSlotItem: QuickSlotButtonModel, viewModel: QuickSlotViewModel) -> QuickSlotTableCell {
        let cell = QuickSlotTableCell(frame: .zero)
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
//        getCellForRow(at: row)
        let cellView = getCellForRow(at: row)

                // Remove the top border line for the first row (index 0)
                if row == 0 {
                    let topBorder = CALayer()
                    topBorder.backgroundColor = NSColor.clear.cgColor
                    cellView.layer?.addSublayer(topBorder)
                }

                return cellView
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 120
    }
}
