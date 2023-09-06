//
//  BookmarkEditorTableView.swift
//  Box42
//
//  Created by Dasol on 2023/09/04.
//

import AppKit
import SnapKit
import Combine

class BookmarkEditorTableView: NSTableView {
    var viewModel: BookmarkViewModel? = BookmarkViewModel.shared
    var cancellables: Set<AnyCancellable> = []
    
    func setup() {
        self.delegate = self
        self.dataSource = self
        
        self.headerView = nil
        self.backgroundColor = .white
        self.selectionHighlightStyle = .none
        
        let column1 = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("BookmarkEditorTableView"))
        self.addTableColumn(column1)
        
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.lightGray.cgColor
        self.layer?.cornerRadius = 20
    }
    
    func setupBindings() {
        viewModel?.$bookMarkList
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.reloadData()
                }
            }
            .store(in: &cancellables)
    }
}

extension BookmarkEditorTableView: NSTableViewDelegate, NSTableViewDataSource {
    func getCellForRow(at row: Int) -> NSView {
        guard let viewModel = viewModel else {
            return NSView()
        }
        
        if row < viewModel.bookMarkList.count {
            return getBookmarkCell(index: row, for: viewModel.bookMarkList[row], viewModel: viewModel)
        } else {
            // MARK: - 다음 버전에 추가 예정
            return getBookmarkCellManager()
        }
    }
    
    private func getBookmarkCell(index: Int, for urlitem: URLItem, viewModel: BookmarkViewModel) -> BookmarkCell {
        let cell = BookmarkCell(frame: .zero)
        cell.configure(index: index, urlitem: urlitem, viewModel: viewModel)
        return cell
    }
    
    private func getBookmarkCellManager() -> BookmarkCellManager {
        let scriptCellManger = BookmarkCellManager(frame: .zero)
        scriptCellManger.configure()
        return scriptCellManger
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return (viewModel?.bookMarkList.count ?? 0) + 1
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        getCellForRow(at: row)
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 44.0
    }
}
