//
//  ScriptsTableView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/28/23.
//

import AppKit
import SnapKit
import Combine

class ScriptsTableView: NSTableView {
    var viewModel: ScriptViewModel? {
        didSet {
            setupBindings()
        }
    }
    
    var cancellables: Set<AnyCancellable> = []
    
    private func setupBindings() {
        viewModel?.$scripts.sink(receiveValue: { [weak self] _ in
            DispatchQueue.main.async {
                self?.reloadData()
            }
        }).store(in: &cancellables)
    }
    
    func setup() {
        self.delegate = self
        self.dataSource = self
        
        let column1 = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("Column1"))
        column1.width = 100.0
        column1.title = "Column 1"
        self.addTableColumn(column1)
    }
}

extension ScriptsTableView: NSTableViewDelegate, NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return viewModel?.scripts.count ?? 0
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = ScriptCell(frame: .zero) // 또는 원하는 frame 값을 설정
        if let script = viewModel?.scripts[row] {
            cell.configure(with: script, viewModel: viewModel)
        }
        return cell // 이 줄을 추가
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 44.0 // 셀 높이를 44로 설정
    }
}
