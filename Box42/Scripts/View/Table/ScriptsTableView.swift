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
            print("ViewModel has been set.")
            setupBindings()
        }
    }

    var cancellables: Set<AnyCancellable> = []
    
    private func setupBindings() {
        print("Setting up bindings...") // 디버깅 로그
        viewModel?.$scripts.sink(receiveValue: { [weak self] newScripts in
            print("Received new scripts: \(newScripts)") // 디버깅 로그
            DispatchQueue.main.async {
                self?.reloadData()
            }
        }).store(in: &cancellables)
    }
    
    func setup() {
        self.delegate = self
        self.dataSource = self
        let column1 = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("Scripts"))
        self.addTableColumn(column1)
    }
}

extension ScriptsTableView: NSTableViewDelegate, NSTableViewDataSource {
    func getCellForRow(at row: Int) -> NSView {
        guard let viewModel = viewModel else {
            return NSView()
        }
        
        if row < viewModel.scripts.count {
            return getScriptCell(for: viewModel.scripts[row], viewModel: viewModel)
        } else {
            // MARK: - 다음 버전에 추가 예정
            return getScriptCellManager()
        }
    }

    private func getScriptCell(for script: Script, viewModel: ScriptViewModel) -> ScriptCell {
        let cell = ScriptCell(frame: .zero)
        cell.configure(with: script, viewModel: viewModel)
        return cell
    }

    private func getScriptCellManager() -> ScriptCellManager {
        let scriptCellManger = ScriptCellManager(frame: .zero)
        return scriptCellManger
    }

    func numberOfRows(in tableView: NSTableView) -> Int {
        return viewModel?.scripts.count ?? 0 // + 1
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        getCellForRow(at: row)
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 44.0
    }
}
