//
//  BoxButtonView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/11/23.
//

import Cocoa
import SnapKit

class CustomTableCellView: NSTableCellView {
    var button: NSButton!
    var deleteButton: NSButton!
    var rowIndex: Int!
}

class BoxButtonViewGroup: NSView {
    var boxVM: WebViewModel = WebViewModel()
    var pinSwitch : NSSwitch = NSSwitch()
    var clickAction: ((NSButton) -> Void)?
    var lastAddedButton: NSView?
    var loginInfo: NSView?
    
    let tableView: NSTableView = {
        let tableView = NSTableView()
        tableView.autoresizingMask = [.width, .height]
        tableView.headerView = nil
        
        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("column1"))
        column.title = ""
        column.width = tableView.frame.size.width
        column.resizingMask = .autoresizingMask
        
        tableView.addTableColumn(column)
        
        return tableView
    }()
    
    let scrollView: NSScrollView = {
        let scrollView = NSScrollView()
        scrollView.borderType = .bezelBorder
        return scrollView
    }()
    
    private var isDeleteButtonsVisible: Bool = false
    let toggleDeleteButton: NSButton = {
        let button = NSButton(title: "-", target: nil, action: nil)
        button.bezelStyle = .rounded
        return button
    }()
    
    @objc func toggleDeleteButtons() {
        print("toggleDeleteButtons")
        isDeleteButtonsVisible.toggle()
        
        let numberOfRows = tableView.numberOfRows
        for row in 0..<numberOfRows {
            if let rowView = tableView.rowView(atRow: row, makeIfNecessary: false) {
                for subview in rowView.subviews {
                    if let cellView = subview as? CustomTableCellView {
                        cellView.deleteButton.isHidden = !isDeleteButtonsVisible
                    }
                }
            }
        }
    }
    
    var buttonArray: [String] = []
    
    let addButton: NSButton = {
        let button = NSButton(title: "+", target: nil, action: nil)
        button.bezelStyle = .rounded
        return button
    }()
    
    init(clickAction: @escaping (NSButton) -> Void) {
        print("init")
        self.clickAction = clickAction
        super.init(frame: BoxSizeManager.shared.buttonGroupSizeNSRect)
        //        setupButtons()
        
        for item in boxVM.webViewURL.URLstring {
            buttonArray.append(item.name)
        }
        
        scrollView.documentView = tableView
        super.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerForDraggedTypes([NSPasteboard.PasteboardType.string])
        
        super.addSubview(toggleDeleteButton)
        toggleDeleteButton.target = self
        toggleDeleteButton.action = #selector(toggleDeleteButtons)
        toggleDeleteButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(0)
        }
        
        super.addSubview(addButton)
        addButton.target = self
        addButton.action = #selector(addCell)
        addButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(toggleDeleteButton.snp.top).offset(-10)
            
        }
    }
    
    @objc func addCell() {
        buttonArray.append("New Cell")  // 'New Cell'은 신규 셀의 이름입니다. 필요에 따라 변경하십시오.
        tableView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        // 뷰의 커스텀 렌더링에 사용됨.
    }
    
    private func setupButtons() {
        for subview in self.subviews {
            subview.removeFromSuperview()
        }
        
        for (name, _) in boxVM.webViewURL.URLstring {
            self.createButton(name)
        }
    }
    
    @objc private func clickBtn(sender: NSButton) {
        clickAction?(sender)
    }
    
    private func createButton(_ title: String) {
        let button: NSButton
        
        if title == "home" {
            button = NSButton(title: "home", image: NSImage(imageLiteralResourceName: "42box_logo"), target: self, action: #selector(clickBtn(sender:)))
            button.imagePosition = .imageOnly
            button.isBordered = false
        } else {
            button = HoverButton()
            button.title = title
            
            button.wantsLayer = true
            button.contentTintColor = NSColor.black
            button.layer?.borderColor = NSColor.black.cgColor
            button.layer?.borderWidth = 1.0
            button.layer?.cornerRadius = 5.0
            button.layer?.opacity = 0.7
        }
        super.addSubview(button)
        
        button.target = self
        button.action = #selector(clickBtn(sender:))
        
        let fontSize: CGFloat = 16.0
        button.font = NSFont.systemFont(ofSize: fontSize)
        button.setButtonType(.momentaryLight)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            
            if title == "home" {
                make.height.equalTo(50)
            } else {
                make.height.equalTo(50)
            }
            
            if let lastButton = lastAddedButton {
                make.top.equalTo(lastButton.snp.bottom).offset(10)
            } else {
                make.top.equalToSuperview().offset(10)
            }
        }
        lastAddedButton = button
    }
}

//NSTableViewDelegate
extension BoxButtonViewGroup: NSTableViewDataSource, NSTableViewDelegate {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return buttonArray.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = CustomTableCellView()
        cellView.layer?.backgroundColor = NSColor.red.cgColor
        cellView.rowIndex = row
        
        let button = NSButton(title: buttonArray[row], target: self, action: #selector(buttonClicked(_:)))
        button.tag = row
        cellView.addSubview(button)
        
        let fontSize: CGFloat = 16.0
        button.font = NSFont.systemFont(ofSize: fontSize)
        button.setButtonType(.momentaryLight)
        button.bezelStyle = .shadowlessSquare
        
        button.wantsLayer = true
        button.layer?.borderWidth = 0
        button.layer?.cornerRadius = 10
        button.layer?.backgroundColor = NSColor.orange.cgColor
        
        button.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.top.bottom.equalToSuperview().inset(5)
        }
        
        let deleteButton = NSButton(title: "삭제", target: self, action: #selector(deleteButtonClicked(_:)))
        deleteButton.tag = row
        deleteButton.bezelStyle = .shadowlessSquare
        deleteButton.wantsLayer = true
        deleteButton.layer?.borderWidth = 0
        deleteButton.layer?.cornerRadius = 10
        deleteButton.layer?.backgroundColor = NSColor.red.cgColor
        
        cellView.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-5)
            make.top.bottom.equalToSuperview().inset(5)
        }
        cellView.deleteButton = deleteButton
        cellView.deleteButton.isHidden = !isDeleteButtonsVisible
        
        return cellView
    }
    
    
    @objc func deleteButtonClicked(_ sender: NSButton) {
        let row = sender.tag
        print("Delete button clicked in row: \(row)")
        
        // 데이터 목록에서 항목 제거
        buttonArray.remove(at: row)
        tableView.reloadData()
        // 테이블 뷰에서 행 제거 및 셀 인덱스 업데이트
        tableView.removeRows(at: IndexSet(integer: row), withAnimation: .effectFade)
        for (_, subview) in tableView.subviews.enumerated() {
            guard let cellView = subview as? CustomTableCellView else {
                continue
            }
            
            cellView.rowIndex = tableView.row(for: cellView)
            cellView.button.tag = cellView.rowIndex
            cellView.deleteButton.tag = cellView.rowIndex
            
            cellView.button.title = buttonArray[cellView.rowIndex]
        }
    }
    
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 40.0
    }
    
    @objc func buttonClicked(_ sender: NSButton) {
        let row = sender.tag
        print("Button clicked in row: \(row)")
    }
    
    // Drag and Drop methods
    func tableView(_ tableView: NSTableView, pasteboardWriterForRow row: Int) -> NSPasteboardWriting? {
        let pasteboardItem = NSPasteboardItem()
        pasteboardItem.setString(String(row), forType: .string)
        return pasteboardItem
    }
    
    func tableView(_ tableView: NSTableView, validateDrop info: NSDraggingInfo, proposedRow row: Int, proposedDropOperation dropOperation: NSTableView.DropOperation) -> NSDragOperation {
        if dropOperation == .above {
            return .move
        } else {
            return []
        }
    }
    
    func tableView(_ aTableView: NSTableView, acceptDrop info: NSDraggingInfo, row: Int, dropOperation: NSTableView.DropOperation) -> Bool {
        guard let str = info.draggingPasteboard.string(forType: .string), let from = Int(str) else {
            return false
        }
        
        let to = (from < row) ? row - 1 : row
        let item = buttonArray[from]
        buttonArray.remove(at: from)
        buttonArray.insert(item, at: to)
        tableView.reloadData()
        
        for (_, subview) in tableView.subviews.enumerated() {
            guard let cellView = subview as? CustomTableCellView else {
                continue
            }
            
            cellView.button.title = buttonArray[cellView.rowIndex]
        }
        
        return true
    }
}
