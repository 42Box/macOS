//
//  PreferencesViewController.swift
//  Box42
//
//  Created by Chanhee Kim on 7/24/23.
//

import Cocoa
import SnapKit

class PreferencesViewController: NSViewController {
    var prefTableView : NSTableView?
    
    override func loadView() {
        self.view = NSView()
        self.view.wantsLayer = true
        self.view.layer?.backgroundColor = NSColor.blue.cgColor
        
        prefTableView = NSTableView(frame: .zero)
        // Column 추가
        let column1 = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("Column1"))
        column1.width = 100.0
        column1.title = "Column 1"
        prefTableView?.addTableColumn(column1)
        
        // delegate와 dataSource 설정
        prefTableView?.delegate = self
        prefTableView?.dataSource = self
        
        // TableView를 스크롤 뷰에 추가 (일반적으로 NSTableView는 NSScrollView 안에 위치합니다)
        let scrollView = NSScrollView()
        scrollView.documentView = prefTableView
        self.view.addSubview(scrollView)
        
        
        scrollView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        
        prefTableView?.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
}

extension PreferencesViewController: NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 10 // 총 로우 수
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("MyCell"), owner: self) as? NSTableCellView ?? NSTableCellView()
        cell.textField?.stringValue = "Row \(row), Column \(tableColumn?.identifier ?? NSUserInterfaceItemIdentifier(""))"
        return cell
    }

    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 44.0 // 셀 높이를 44로 설정
    }
}

