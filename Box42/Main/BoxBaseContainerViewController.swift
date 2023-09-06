//
//  BoxBaseContainerViewController.swift
//  Box42
//
//  Created by Chan on 2023/03/17.
//

import Cocoa
import SnapKit
import Combine

class BoxBaseContainerViewController: NSViewController {
    // MARK: - LeftContainer
    var splitView: BoxBaseSplitView = BoxBaseSplitView()
    var contentGroup: BoxContentsViewGroup = BoxContentsViewGroup()
    var toolbarGroupVC: ToolbarViewController = ToolbarViewController()
    var quickSlotGroupVC: QuickSlotViewController = QuickSlotViewController()
    var functionGroupVC: BoxFunctionViewController = BoxFunctionViewController()
    let windowViewGroupVC: WindowButtonViewController = WindowButtonViewController()
    var leftView: MovableContainerView = MovableContainerView()
    //    var buttonGroupVC: ButtonGroupViewController = ButtonGroupViewController()
    
    // MARK: - QuickSlot
    var preferenceVC: PreferencesViewController = PreferencesViewController()
    var scriptsVC: ScriptsViewController = ScriptsViewController()
    
    weak var menubarVCDelegate: MenubarViewControllerDelegate? // extension
    
    var quickSlotManagerVC: QuickSlotManagerViewController = QuickSlotManagerViewController()
    var quickSlotButtonCollectionVC: QuickSlotButtonCollectionViewController =  QuickSlotButtonCollectionViewController()
    
    // MARK: - table View
    var viewModel: BookmarkViewModel? = BookmarkViewModel.shared
    
    var cancellables: Set<AnyCancellable> = []
    
    private let bookMarkView: NSView = {
        let view = NSView()
        return view
    }()
    
    let tableView: NSTableView = {
        let tableView = NSTableView()
        tableView.autoresizingMask = [.width, .height]
        tableView.headerView = nil
        return tableView
    }()
    
    
    // MARK: - table View End
    
    private func setupBindings() {
        print("Setting up bindings...") // 디버깅 로그
        viewModel?.$bookMarkList.sink(receiveValue: { [weak self] newScripts in
            print("Received new scripts: \(newScripts)") // 디버깅 로그
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }).store(in: &cancellables)
    }
    
    var selectedRow: Int?
    var selectedButton: DraggableButton?
    
    override func loadView() {
        toolbarGroupVC.baseContainerVC = self
        
        self.view = NSView()
        self.view.wantsLayer=true
        self.view.layer?.backgroundColor = NSColor(hex: "#E7E7E7").cgColor
        self.view.snp.makeConstraints { make in
            make.width.equalTo(BoxSizeManager.shared.size.width)
            make.height.equalTo(BoxSizeManager.shared.size.height)
        }
        
        //        splitView.adjustSubviews()
        //        splitView.setNeedsDisplay(splitView.bounds)
        //        splitView.addArrangedSubview(leftView)
        //        splitView.addArrangedSubview(contentGroup)
        //        self.view.addSubview(splitView)
        //
        //        splitView.snp.makeConstraints { make in
        //            make.edges.equalToSuperview().inset(10)
        //        }
        self.view.addSubview(leftView)
        self.view.addSubview(contentGroup)
        
        leftView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(12)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalTo(contentGroup.snp.leading).offset(-18)
            make.width.equalTo((268 + 16 + 18))
        }
        
        contentGroup.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview().inset(12)
            make.leading.equalTo(leftView.snp.trailing)
        }
        
        let borderView = NSView()
        borderView.wantsLayer = true
        borderView.layer?.backgroundColor = NSColor(red: 0.773, green: 0.773, blue: 0.773, alpha: 1).cgColor
        leftView.addSubview(windowViewGroupVC.view)
        leftView.addSubview(bookMarkView)
        leftView.addSubview(toolbarGroupVC.view)
        leftView.addSubview(borderView)
        leftView.addSubview(quickSlotGroupVC.view)
        leftView.addSubview(functionGroupVC.view)
        
        windowViewGroupVC.view.snp.makeConstraints { make in
            make.top.equalTo(leftView)
            make.left.equalTo(leftView).offset(3)
            make.width.equalTo(77)
            make.height.equalTo(21)
        }
        toolbarGroupVC.view.snp.makeConstraints { make in
            make.top.equalTo(windowViewGroupVC.view.snp.bottom).offset(31)
            make.right.equalTo(leftView)
            make.left.equalTo(leftView)
            make.height.equalTo(44 + 14 + 24)
        }
        bookMarkView.snp.makeConstraints { make in
            make.top.equalTo(toolbarGroupVC.view.snp.bottom).offset(Constants.UI.groupAutolayout)
            make.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalTo(quickSlotGroupVC.view.snp.top).offset(-Constants.UI.groupAutolayout)
        }
        borderView.snp.makeConstraints { make in
            make.top.equalTo(bookMarkView.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        quickSlotGroupVC.view.snp.makeConstraints { make in
            make.top.equalTo(borderView.snp.bottom).offset(0)
            make.bottom.equalTo(functionGroupVC.view.snp.top).offset(-27)
            make.right.equalTo(leftView).offset(0)
            make.left.equalTo(leftView)
            make.height.equalTo(178)
        }
        functionGroupVC.view.snp.makeConstraints { make in
            make.right.equalTo(leftView).offset(-Constants.UI.groupAutolayout)
            make.left.bottom.equalTo(leftView)
        }
        
        let superView = NSView()
        
        let imageView = NSImageView()
        imageView.image = NSImage(named: NSImage.Name("bookmark"))
        imageView.image?.size = NSSize(width: 18, height: 18)
        superView.addSubview(imageView)
        
        let label = NSTextField(labelWithString: "북마크")
        label.textColor = NSColor.black
        label.font = NSFont.boldSystemFont(ofSize: 16)
        superView.addSubview(label)
        
        let buttonImage = NSImage(named: NSImage.Name("add"))!
        buttonImage.size = NSSize(width: 24, height: 24)
        let button = NSButton(image: buttonImage, target: self, action: #selector(addBookMarkButtonClicked(_:)))
        button.setButtonType(.momentaryChange)
        button.bezelStyle = .texturedRounded
        button.isBordered = false
        button.wantsLayer = true
        button.layer?.backgroundColor = NSColor(hex:"#E7E7E7").cgColor
        superView.addSubview(button)
        
        imageView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        label.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).offset(8)
            make.centerY.equalToSuperview()
        }
        
        button.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        tableView.wantsLayer = true
        tableView.backgroundColor = NSColor(hex: "#E7E7E7")
        tableView.focusRingType = .none
        tableView.headerView = nil
        tableView.autoresizingMask = [.width, .height]
        tableView.selectionHighlightStyle = .none
        tableView.intercellSpacing = NSSize(width: 0, height: 0)
        tableView.setDraggingSourceOperationMask(.move, forLocal: true)
        
        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("column1"))
        column.title = ""
        //        column.width = 100
        column.resizingMask = .autoresizingMask
        
        tableView.addTableColumn(column)
        
        let scrollView = NSScrollView()
        scrollView.documentView = tableView
        
        bookMarkView.addSubview(superView)
        bookMarkView.addSubview(scrollView)
        //        bookMarkView.addSubview(tableView)
        
        superView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.trailing.equalToSuperview().offset(0)
            make.height.equalTo(24)
        }
        
        //        tableView.snp.makeConstraints { make in
        //            make.top.equalTo(stackView.snp.bottom).offset(0)
        //            make.leading.equalToSuperview()
        //        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(superView.snp.bottom).offset(0)
            make.leading.trailing.equalToSuperview().offset(0)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerForDraggedTypes([NSPasteboard.PasteboardType.string])
    }
    
    @objc func addBookMarkButtonClicked(_ sender: NSButton) {
        contentGroup.removeAllSubviews()
        
        let bookmarkTableView = BookmarkEditorTableView()
        bookmarkTableView.setup()
        bookmarkTableView.setupBindings()
        
        let scrollView = NSScrollView()
        contentGroup.addSubview(scrollView)
        scrollView.documentView = bookmarkTableView
        
        scrollView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        
        bookmarkTableView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
    }
    
    override func viewDidLoad() {
        //        self.view.wantsLayer = true
        super.viewDidLoad()
        setupBindings()
        //
        ////        self.view.layer?.backgroundColor = NSColor(hex: "#FF9548").cgColor
        //        self.view.layer?.backgroundColor = NSColor(hex: "#E7E7E7").cgColor
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleButtonTapped), name: .collectionButtonTapped, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(headerTappedQuickSlotManagerHandle), name: .collectionHeaderTapped, object: nil)
    }
    
    //    func BoxButtonViewGroupInit() -> BoxButtonViewGroup {
    //
    //        let buttonGroup = BoxButtonViewGroup { sender in
    //            self.clickBtn(sender: sender)
    //        }
    //
    //        return buttonGroup
    //    }
    //
    //    private func leftContainerInit() {
    //        leftContainer.frame.size.width = BoxSizeManager.shared.windowButtonGroupSize.width
    //        leftContainer.frame.size.height = BoxSizeManager.shared.windowButtonGroupSize.height
    //        leftContainer.addSubview(windowViewGroupVC.view)
    //        leftContainer.addSubview(buttonGroupVC.view)
    //        leftContainer.addSubview(toolbarGroupVC.view)
    //        leftContainer.addSubview(quickSlotGroupVC.view)
    //        leftContainer.addSubview(functionGroupVC.view)
    //
    //        leftContainerAutolayout()
    //    }
    //
    //    private func leftContainerAutolayout() {
    //        windowViewGroupVC.view.snp.makeConstraints { make in
    //            make.top.equalTo(leftContainer)
    //            make.left.equalTo(leftContainer).offset(3)
    //            make.width.equalTo(77)
    //            make.height.equalTo(21)
    //        }
    //
    //        toolbarGroupVC.view.snp.makeConstraints { make in
    //            make.top.equalTo(windowViewGroupVC.view.snp.bottom).offset(31)
    //            make.right.equalTo(leftContainer)
    //            make.left.equalTo(leftContainer)
    //            make.height.equalTo(44 + 14 + 24)
    //        }
    //
    //        buttonGroupVC.view.snp.makeConstraints { make in
    //            make.top.equalTo(toolbarGroupVC.view.snp.bottom).offset(Constants.UI.groupAutolayout)
    //            make.right.equalTo(leftContainer).offset(-Constants.UI.groupAutolayout)
    //            make.left.equalTo(leftContainer)
    //            make.bottom.equalTo(quickSlotGroupVC.view.snp.top).offset(-Constants.UI.groupAutolayout)
    //        }
    //
    //       quickSlotGroupVC.view.snp.makeConstraints { make in
    //           make.bottom.equalTo(functionGroupVC.view.snp.top).offset(-27)
    //           make.right.equalTo(leftContainer).offset(-Constants.UI.groupAutolayout)
    //           make.left.equalTo(leftContainer)
    //           make.height.equalTo(178)
    //       }
    //
    //        functionGroupVC.view.snp.makeConstraints { make in
    //            make.right.equalTo(leftContainer).offset(-Constants.UI.groupAutolayout)
    //            make.left.bottom.equalTo(leftContainer)
    //        }
    //    }
    //
    //    func viewInit() {
    //        self.boxViewSizeInit()
    //
    //        splitView.addArrangedSubview(leftContainer)
    //        splitView.addArrangedSubview(contentGroup)
    //        self.view.addSubview(splitView)
    //
    //        splitView.snp.makeConstraints { make in
    //            make.top.equalToSuperview().offset(Constants.UI.groupAutolayout)
    //            make.left.equalToSuperview().offset(Constants.UI.groupAutolayout)
    //            make.right.equalToSuperview().offset(-Constants.UI.groupAutolayout)
    //            make.bottom.equalToSuperview().offset(-Constants.UI.groupAutolayout)
    //        }
    //    }
    //
    //    func boxViewSizeInit() {
    //        self.view.frame.size.width = BoxSizeManager.shared.size.width
    //        self.view.frame.size.height = BoxSizeManager.shared.size.height
    //    }
}

extension BoxBaseContainerViewController: NSSplitViewDelegate {
    func splitView(_ splitView: NSSplitView, shouldAdjustSizeOfSubview view: NSView) -> Bool {
        return false
    }
    
}

extension BoxBaseContainerViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, pasteboardWriterForRow row: Int) -> NSPasteboardWriting? {
        let pasteboardItem = NSPasteboardItem()
        pasteboardItem.setString(String(row), forType: .string)
        return pasteboardItem
    }
}

class ButtonTableCellView: NSTableCellView {
    var button: NSButton!
    var deleteButton: NSButton!
    var rowIndex: Int!
    
    override func viewWillDraw() {
        super.viewWillDraw()
    }
}


extension BoxBaseContainerViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return BookmarkViewModel.shared.bookMarkList.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = ButtonTableCellView()
        cellView.rowIndex = row
        
        let button = DraggableButton(frame: NSRect(x: 0, y: 0, width: 268, height: 44))
        button.tag = row
        button.bezelStyle = .inline
        button.isBordered = false
        button.title = ""
        button.associatedString = BookmarkViewModel.shared.bookMarkList[row].name
        button.registerForDraggedTypes([NSPasteboard.PasteboardType.string])
        button.target = self
        button.action = #selector(buttonClicked(_:))
        button.delegate = self
        
        let label = NSTextField(frame: NSRect(x: 26 + 21 + 8, y: 25 / 2, width: button.bounds.width, height: button.bounds.height))
        
        label.stringValue = BookmarkViewModel.shared.bookMarkList[row].name
        label.backgroundColor = .clear
        label.isBordered = false
        label.isEditable = false
        
        let attributes : [NSAttributedString.Key : Any] =
            [
                NSAttributedString.Key.font : NSFont.systemFont(ofSize:18.0, weight: .light),
                NSAttributedString.Key.foregroundColor : NSColor.black,
            ]
        let attributedStringTitle = NSAttributedString(string: label.stringValue , attributes:
                                                        attributes)
        label.attributedStringValue=attributedStringTitle
        button.addSubview(label)
        
        //        let image = NSImage(named: NSImage.Name("bookmark-default"))
        //        image?.size = NSSize(width: 21, height: 21)
        //        button.image = image
        //        button.imagePosition = .imageLeading
        //        button.image?.alignmentRect = NSRect(x: 0, y: 0, width: 21, height: 21)
        
        let imageView = NSImageView(frame: NSRect(x: 26, y: 25 / 2, width: 21, height: 21))
        imageView.image = NSImage(named: NSImage.Name("bookmark-default"))
        imageView.imageScaling = .scaleProportionallyUpOrDown
        imageView.imageAlignment = .alignCenter
        button.addSubview(imageView)
        
        cellView.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(44)
        }
        
        tableView.rowHeight = 50
        
        if row == selectedRow {
            button.wantsLayer = true
            button.layer?.cornerRadius = 12
            button.layer?.backgroundColor = NSColor.white.cgColor
        } else {
            button.wantsLayer = true
            button.layer?.cornerRadius = 12
            button.layer?.backgroundColor = NSColor.clear.cgColor
        }
        
        return cellView
    }
    
    @objc func buttonClicked(_ sender: DraggableButton) {
        selectedButton?.layer?.backgroundColor = NSColor.clear.cgColor
        
        selectedButton = sender
        sender.layer?.backgroundColor = NSColor.white.cgColor
        
        if sender.tag < BookmarkViewModel.shared.bookMarkList.count {
            if let url = URL(string: BookmarkViewModel.shared.bookMarkList[sender.tag].url) {
                print(url)
                clickBtn(sender: sender)
            }
        }
    }
    
    func clickBtn(sender: Any?) {
        if let button = sender as? NSButton {
            guard let clickCount = NSApp.currentEvent?.clickCount else { return }
            if clickCount == 2 {
                WebViewManager.shared.list[button.title]?.reload()
                print("Dobule Click")
            } else if clickCount > 2 {
                if let currentURL = WebViewManager.shared.hostingWebView?.url {
                    NSWorkspace.shared.open(currentURL)
                }
                print("Triple Click")
            } else if clickCount < 2 {
                contentGroup.removeAllSubviews()
                contentGroup.showWebviews(button) // sender.tag
            }
        } else {
            if let str = sender as? String {
                if str == "box" {
                    contentGroup.removeAllSubviews()
                    print("box inside")
                }
            }
        }
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
        let item = BookmarkViewModel.shared.bookMarkList[from]
        BookmarkViewModel.shared.bookMarkList.remove(at: from)
        BookmarkViewModel.shared.bookMarkList.insert(item, at: to)
        
        for (_, subview) in tableView.subviews.enumerated() {
            guard let cellView = subview as? CustomTableCellView else {
                continue
            }
            cellView.button.title = BookmarkViewModel.shared.bookMarkList[cellView.rowIndex].url
        }
        
        return true
    }
}

//extension BoxBaseContainerViewController: BoxFunctionViewControllerDelegate {
//    func didTapBoxButton() {
//        clickBtn(sender: "box")
//    }
//}

extension BoxBaseContainerViewController {
    @objc func handleButtonTapped(notification: NSNotification) {
        if let button = notification.object as? NSButton {
            if button.title == QuickSlotUI.title.preferences {
                print("Button with title \(button.title) was tapped in BaseVC")
                contentGroup.showPreferences()
            }
            
            if button.title == QuickSlotUI.title.scripts {
                print("Button with title \(button.title) was tapped in BaseVC")
                contentGroup.showScripts()
            }
            
            if button.title == QuickSlotUI.title.user {
                //                        if let url = URL(string: "x-apple.systempreferences:com.apple.preference.keyboard") {
                //                            NSWorkspace.shared.open(url)
                //
                //                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                //                                if let url = URL(string: "x-apple.systempreferences:com.apple.preference.general") {
                //                                    NSWorkspace.shared.open(url)
                //                                }
                //                            }
                //                        }
                if let appURL = Bundle.main.url(forResource: "prefsHelper", withExtension: "app") {
                    let workspace = NSWorkspace.shared
                    workspace.open(appURL, configuration: NSWorkspace.OpenConfiguration()) { (runningApp, error) in
                        if let error = error {
                            print("Error opening app:", error.localizedDescription)
                        } else {
                            print("App opened successfully")
                        }
                    }
                } else {
                    print("App not found")
                }
            }
        }
    }
}

extension BoxBaseContainerViewController {
    @objc func headerTappedQuickSlotManagerHandle(notification: NSNotification) {
        print("QuickSlotManager")
        contentGroup.removeAllSubviews()
        print(quickSlotManagerVC)
        contentGroup.addSubview(quickSlotManagerVC.view)
        quickSlotManagerVC.view.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
}
