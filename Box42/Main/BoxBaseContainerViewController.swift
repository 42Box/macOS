//
//  BoxBaseContainerViewController.swift
//  Box42
//
//  Created by Chan on 2023/03/17.
//

import Cocoa
import SnapKit

let bookMarkList = [
    ("home", "https://42box.kr/"),
    ("23Coaltheme", "https://42box.github.io/front-end/"),
    ("Box 42", "https://42box.github.io/front-end/#/box"),
    ("Intra 42", "https://intra.42.fr"),
    ("Jiphyeonjeon", "https://42library.kr"),
    ("42STAT", "https://stat.42seoul.kr/home"),
    ("24Hane", "https://24hoursarenotenough.42seoul.kr"),
    ("80kCoding", "https://80000coding.oopy.io"),
    ("where42", "https://www.where42.kr"),
    ("cabi", "https://cabi.42seoul.io/"),
    ("42gg", "https://42gg.kr/"),
    ("textart", "https://textart.sh/"),
]

class BoxBaseContainerViewController: NSViewController {
    // MARK: - LeftContainer
//    var splitView: BoxBaseSplitView = BoxBaseSplitView()
    var contentGroup: BoxContentsViewGroup = BoxContentsViewGroup()
    var toolbarGroupVC: ToolbarViewController = ToolbarViewController()
    var quickSlotGroupVC: QuickSlotViewController = QuickSlotViewController()
    var functionGroupVC: BoxFunctionViewController = BoxFunctionViewController()
    let windowViewGroupVC: WindowButtonViewController = WindowButtonViewController()
//    var leftContainer: MovableContainerView = MovableContainerView()
//    var buttonGroupVC: ButtonGroupViewController = ButtonGroupViewController()
    
    // MARK: - QuickSlot
    var preferenceVC: PreferencesViewController = PreferencesViewController()
    var scriptsVC: ScriptsViewController = ScriptsViewController()
        
    weak var menubarVCDelegate: MenubarViewControllerDelegate? // extension
    
    var quickSlotManagerVC: QuickSlotManagerViewController = QuickSlotManagerViewController()
    var quickSlotButtonCollectionVC: QuickSlotButtonCollectionViewController =  QuickSlotButtonCollectionViewController()

    private let splitView: NSSplitView = {
        let splitView = NSSplitView()
        splitView.isVertical = true
        splitView.dividerStyle = .thick
        return splitView
    }()
    
    private let leftView: NSView = {
        let view = NSView()
        view.frame.size.width = 302 - 12
        view.frame.size.height = 1200
        return view
    }()
    
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
    
    var buttonTitleArray = bookMarkList.map { $0.0 }
    var urlArray = bookMarkList.map { $0.1 }
    var selectedRow: Int?
    var selectedButton: DraggableButton?
    
    override func loadView() {
        self.view = NSView()
        self.view.wantsLayer=true
        self.view.layer?.backgroundColor = NSColor(hex: "#E7E7E7").cgColor
        self.view.snp.makeConstraints { make in
            make.width.equalTo(BoxSizeManager.shared.size.width)
            make.height.equalTo(BoxSizeManager.shared.size.height)
        }
        
        splitView.addArrangedSubview(leftView)
        splitView.addArrangedSubview(contentGroup)
        self.view.addSubview(splitView)
        
        splitView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        leftView.addSubview(windowViewGroupVC.view)
        leftView.addSubview(bookMarkView)
        leftView.addSubview(toolbarGroupVC.view)
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
            make.bottom.equalTo(quickSlotGroupVC.view.snp.top).offset(-Constants.UI.groupAutolayout)
        }
        quickSlotGroupVC.view.snp.makeConstraints { make in
            make.bottom.equalTo(functionGroupVC.view.snp.top).offset(-27)
            make.right.equalTo(leftView).offset(-Constants.UI.groupAutolayout)
            make.left.equalTo(leftView)
            make.height.equalTo(178)
        }
        functionGroupVC.view.snp.makeConstraints { make in
            make.right.equalTo(leftView).offset(-Constants.UI.groupAutolayout)
            make.left.bottom.equalTo(leftView)
        }
        
        splitView.delegate = self
        
        let stackView = NSStackView()
        stackView.orientation = .horizontal
        stackView.spacing = 6
        stackView.alignment = .centerY
        
        let imageView = NSImageView()
        imageView.image = NSImage(named: NSImage.Name("bookmark"))
        
        let label = NSTextField(labelWithString: "북마크")
        label.textColor = NSColor.black
        label.font = NSFont.boldSystemFont(ofSize: 16)
        
        let buttonImage = NSImage(named: NSImage.Name("add"))!
        buttonImage.size = NSSize(width: 24, height: 24)
        let button = NSButton(image: buttonImage, target: self, action: #selector(addBookMarkButtonClicked(_:)))
        button.setButtonType(.momentaryChange)
        button.bezelStyle = .texturedRounded
        button.isBordered = false
        button.wantsLayer = true
        button.layer?.backgroundColor = NSColor(hex: "#E7E7E7").cgColor
        let spacerView = NSView()
        spacerView.snp.makeConstraints { make in
            make.width.equalTo(173)
        }
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(spacerView)
        stackView.addArrangedSubview(button)
        
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
        scrollView.hasVerticalScroller = true
        scrollView.documentView = tableView
        
        bookMarkView.addSubview(stackView)
        bookMarkView.addSubview(scrollView)
        //        bookMarkView.addSubview(tableView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.trailing.equalToSuperview().offset(0)
            make.height.equalTo(24)
        }
        
        //        tableView.snp.makeConstraints { make in
        //            make.top.equalTo(stackView.snp.bottom).offset(0)
        //            make.leading.equalToSuperview()
        //        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(0)
            make.leading.trailing.equalToSuperview().offset(0)
            make.bottom.equalToSuperview()
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerForDraggedTypes([NSPasteboard.PasteboardType.string])
    }
    
    @objc func addBookMarkButtonClicked(_ sender: NSButton) {
        splitView.removeArrangedSubview(contentGroup)
        contentGroup.removeFromSuperview()
        
        let newView = BookmarkEditorView(bookMarkList: bookMarkList)
        newView.wantsLayer = true
        newView.layer?.backgroundColor = NSColor.black.cgColor
        newView.layer?.cornerRadius = 20
        newView.frame.size = contentGroup.frame.size
        
        contentGroup.addSubview(newView)
        newView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        splitView.addArrangedSubview(contentGroup)
    }
    
    override func viewDidLoad() {
//        self.view.wantsLayer = true
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
    
//    func clickBtn(sender: Any?) {
//        if let button = sender as? NSButton {
//            guard let clickCount = NSApp.currentEvent?.clickCount else { return }
//            if clickCount == 2 {
//                WebViewManager.shared.list[button.title]!.reload()
//                print("Dobule Click")
//            } else if clickCount > 2 {
//                if let currentURL = WebViewManager.shared.hostingWebView?.url {
//                    NSWorkspace.shared.open(currentURL)
//                }
//                print("Triple Click")
//            } else if clickCount < 2 {
//                contentGroup.removeAllSubviews()
//                contentGroup.showWebviews(button)
//            }
//        } else {
//            if let str = sender as? String {
//                if str == "box" {
//                    contentGroup.removeAllSubviews()
//                    print("box inside")
//                }
//            }
//        }
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
    func splitView(_ splitView: NSSplitView, constrainMinCoordinate proposedMinimumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        
        if dividerIndex == 0 {
            return CGFloat(132).pointsToPixels()
        }
        return proposedMinimumPosition
    }
    
    func splitView(_ splitView: NSSplitView, constrainMaxCoordinate proposedMaximumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        if dividerIndex == 0 {
            return CGFloat(302).pointsToPixels()
        }
        return proposedMaximumPosition
    }
    
    func splitView(_ splitView: NSSplitView, resizeSubviewsWithOldSize oldSize: NSSize) {
        let dividerThickness = splitView.dividerThickness
        let newWidth = splitView.frame.width - dividerThickness
        
        let leftWidth = leftView.frame.width
        let contentWidth = newWidth - leftWidth
        
        leftView.frame = NSRect(x: 0, y: 0, width: leftWidth, height: splitView.bounds.height)
        contentGroup.frame = NSRect(x: leftWidth + dividerThickness, y: 0, width: contentWidth, height: splitView.bounds.height)
    }
}

extension BoxBaseContainerViewController: NSTableViewDelegate {
    func tableView(_ tableView: NSTableView, pasteboardWriterForRow row: Int) -> NSPasteboardWriting? {
        let pasteboardItem = NSPasteboardItem()
        pasteboardItem.setString(String(row), forType: .string)
        return pasteboardItem
    }
    
    func sendUpdatedDataToServer() {
        let urlList = zip(buttonTitleArray, urlArray).map { ["name": $0.0, "url": $0.1] }
        let jsonData = try? JSONSerialization.data(withJSONObject: ["urlList": urlList])
        
        var request = URLRequest(url: URL(string:"https://api.42box.kr/user-service/users/me/url-list")!)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with:request) { (data, response, error) in
            if error != nil{
                print(error!.localizedDescription)
            }
            else{
                print("Data posted successfully")
            }
        }.resume()
    }
    
}

class ButtonTableCellView: NSTableCellView {
    var button: NSButton!
    var deleteButton: NSButton!
    var rowIndex: Int!
    
    override func viewWillDraw() {
        super.viewWillDraw()
        self.frame.size.width = 268.0
        self.frame = NSRect(x: self.frame.origin.x - 3, y: self.frame.origin.y,
                            width: self.frame.size.width, height: self.frame.size.height)
    }
}


extension BoxBaseContainerViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return buttonTitleArray.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = ButtonTableCellView()
        cellView.rowIndex = row
        
        let button = DraggableButton(frame: NSRect(x: 0, y: 0, width: 300, height: 44))
        button.tag = row
        button.bezelStyle = .inline
        button.isBordered = false
        button.title = ""
        button.registerForDraggedTypes([NSPasteboard.PasteboardType.string])
        button.target = self
        button.action = #selector(buttonClicked(_:))
        button.delegate = self
        
        let label = NSTextField(frame: NSRect(x: 26 + 21 + 8, y: 25 / 2, width: button.bounds.width, height: button.bounds.height))
        
        label.stringValue = buttonTitleArray[row]
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
            //            make.width.equalTo(268)
            make.width.lessThanOrEqualTo(268)
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
        
        // Update the reference to the currently selected button and change its background color.
        selectedButton = sender
        sender.layer?.backgroundColor = NSColor.white.cgColor
        
        if sender.tag < urlArray.count {
            if let url = URL(string:urlArray[sender.tag]) {
                print(url)
                contentGroup.webView.load(URLRequest(url: url))
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
        let item = buttonTitleArray[from]
        buttonTitleArray.remove(at: from)
        buttonTitleArray.insert(item, at: to)
        tableView.reloadData()
        
        for (_, subview) in tableView.subviews.enumerated() {
            guard let cellView = subview as? CustomTableCellView else {
                continue
            }
            
            cellView.button.title = buttonTitleArray[cellView.rowIndex]
        }
        
        return true
    }
}

class DraggableButton: NSButton, NSDraggingSource {
    weak var delegate: BoxBaseContainerViewController?
    var mouseDownEvent: NSEvent?
    
    func draggingSession(_ session: NSDraggingSession, sourceOperationMaskFor context: NSDraggingContext) -> NSDragOperation {
        return .move
    }
    
    override func mouseUp(with event: NSEvent) {
        print("mouseUp")
        if let down = self.mouseDownEvent {
            if event.locationInWindow == down.locationInWindow {
                self.target?.perform(self.action, with: self)
            }
            
            super.mouseUp(with:event)
            self.mouseDownEvent = nil
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        print("mouseDown")
        self.mouseDownEvent = event
        if event.clickCount > 1 {
            self.target?.perform(self.action, with: self)
        }
    }
    
    override func mouseDragged(with event: NSEvent) {
        guard let down = self.mouseDownEvent else { return }
        
        let distance = hypot(
            down.locationInWindow.x - event.locationInWindow.x,
            down.locationInWindow.y - event.locationInWindow.y)
        
        if distance > 3 { // Adjust this as needed
            let pasteboardItem = NSPasteboardItem()
            pasteboardItem.setString("\(self.tag)", forType: .string)
            
            let draggingItem = NSDraggingItem(pasteboardWriter: pasteboardItem)
            
            // Create a snapshot of the button
            let snapshot = self.snapshot()
            
            // Set the dragging frame and contents
            draggingItem.setDraggingFrame(self.bounds, contents:snapshot)
            
            beginDraggingSession(with: [draggingItem], event:self.mouseDownEvent!, source:self)
            
            self.mouseDownEvent = nil
        }
    }
    
    func snapshot() -> NSImage? {
        guard let bitmapRep = bitmapImageRepForCachingDisplay(in: bounds) else { return nil }
        cacheDisplay(in: bounds, to: bitmapRep)
        let image = NSImage(size: bounds.size)
        image.addRepresentation(bitmapRep)
        return image
    }
    
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        
        let trackingArea = NSTrackingArea(
            rect: bounds,
            options: [.mouseEnteredAndExited, .activeAlways],
            owner: self,
            userInfo: nil
        )
        
        addTrackingArea(trackingArea)
    }
    
    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        
        if self != delegate?.selectedButton {
            wantsLayer = true
            layer?.frame.size = CGSize(width: 268.0, height: 44.0)
            layer?.cornerRadius = 12
            layer?.backgroundColor = NSColor(red: 0.848, green: 0.848, blue: 0.848, alpha: 1).cgColor
        }
    }
    
    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        
        if self != delegate?.selectedButton {
            wantsLayer = true
            layer?.frame.size = CGSize(width: 268.0, height: 44.0)
            layer?.cornerRadius = 12
            layer?.backgroundColor = NSColor.clear.cgColor
        }
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
                print("Button with title \(button.title) was tapped in BaseVC")
                contentGroup.removeAllSubviews()
                print(WebViewManager.shared.hostingWebView!)
                contentGroup.addSubview(WebViewManager.shared.hostingWebView!)
                WebViewManager.shared.hostingWebView!.snp.makeConstraints { make in
                    make.top.bottom.left.right.equalToSuperview()
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
