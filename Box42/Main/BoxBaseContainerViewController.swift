//
//  BoxBaseContainerViewController.swift
//  Box42
//
//  Created by Chan on 2023/03/17.
//

import Cocoa
import SnapKit

let bookMarkList = [
    //    ("home", "https://42box.kr/"),
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
    
    //    var splitView: BoxBaseSplitView = BoxBaseSplitView()
    var contentGroup: BoxContentsViewGroup = BoxContentsViewGroup()
    var toolbarGroupVC: ToolbarViewController = ToolbarViewController()
    var quickSlotGroupVC: QuickSlotViewController = QuickSlotViewController()
    var functionGroupVC: BoxFunctionViewController = BoxFunctionViewController()
    let windowViewGroupVC: WindowButtonViewController = WindowButtonViewController()
    //    var leftContainer: MovableContainerView = MovableContainerView()
    //    var buttonGroupVC: ButtonGroupViewController = ButtonGroupViewController()
    
    weak var menubarVCDelegate: MenubarViewControllerDelegate? // extension
    
    private let splitView: NSSplitView = {
        let splitView = NSSplitView()
        splitView.isVertical = true
        splitView.dividerStyle = .thick
        return splitView
    }()
    
    private let leftView: NSView = {
        let view = NSView()
        view.frame.size.width = BoxSizeManager.shared.windowButtonGroupSize.width
        view.frame.size.height = BoxSizeManager.shared.windowButtonGroupSize.height
        return view
    }()
    
    private let bookMarkView: NSView = {
        let view = NSView()
        return view
    }()
    
    var buttonTitleArray = bookMarkList.map { $0.0 }
    var urlArray = bookMarkList.map { $0.1 }
    
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
            make.left.right.equalTo(leftView)
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
            make.width.equalTo(233)
        }
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(spacerView)
        stackView.addArrangedSubview(button)
        
        
        let tableView = NSTableView()
        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier("column1"))
        column.title = ""
        column.width = leftView.frame.size.width
        tableView.addTableColumn(column)
        
        bookMarkView.addSubview(stackView)
        bookMarkView.addSubview(tableView)
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(24)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(0)
            make.leading.equalToSuperview().offset(-20)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerForDraggedTypes([NSPasteboard.PasteboardType.string])
    }
    
    @objc func addBookMarkButtonClicked(_ sender: NSButton) {
        print("addCellButtonClicked")
    }
    
    //뷰 컨트롤러의 뷰가 메모리에 로드되고 초기화된 후에 호출됩니다.
    override func viewDidLoad() {
        //        self.view.wantsLayer = true
        //        self.view.layer?.backgroundColor = NSColor(hex: "#FF9548").cgColor
        //        self.view.layer?.backgroundColor = NSColor(hex: "#E7E7E7").cgColor
    }
    
    //    func BoxButtonViewGroupInit() -> BoxButtonViewGroup {
    //        let buttonGroup = BoxButtonViewGroup { sender in
    //            self.clickBtn(sender: sender)
    //        }
    //        return buttonGroup
    //    }
    //
    func clickBtn(sender: Any?) {
        if let button = sender as? NSButton {
            guard let clickCount = NSApp.currentEvent?.clickCount else { return }
            if clickCount == 2 {
                WebViewManager.shared.list[button.title]!.reload()
                print("Dobule Click")
            } else if clickCount > 2 {
                if let currentURL = WebViewManager.shared.hostingWebView?.url {
                    NSWorkspace.shared.open(currentURL)
                }
                print("Triple Click")
            } else if clickCount < 2 {
                contentGroup.removeAllSubviews()
                contentGroup.showWebviews(button)
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
    
    //    private func leftContainerInit() {
    //        leftContainer.frame.size.width = BoxSizeManager.shared.windowButtonGroupSize.width
    //        leftContainer.frame.size.height = BoxSizeManager.shared.windowButtonGroupSize.height
    //        leftContainer.addSubview(windowViewGroupVC.view)
    //        leftContainer.addSubview(bookMarkView)
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
    //        bookMarkView.snp.makeConstraints { make in
    //            make.top.equalTo(toolbarGroupVC.view.snp.bottom).offset(Constants.UI.groupAutolayout)
    //            make.right.equalTo(leftContainer).offset(-Constants.UI.groupAutolayout)
    //            make.left.equalTo(leftContainer)
    //            make.bottom.equalTo(quickSlotGroupVC.view.snp.top).offset(-Constants.UI.groupAutolayout)
    //
    //        }
    //
    //        quickSlotGroupVC.view.snp.makeConstraints { make in
    //            make.bottom.equalTo(functionGroupVC.view.snp.top).offset(-27)
    //            make.right.equalTo(leftContainer).offset(-Constants.UI.groupAutolayout)
    //            make.left.equalTo(leftContainer)
    //            make.height.equalTo(178)
    //        }
    //
    //        functionGroupVC.view.snp.makeConstraints { make in
    //            make.right.equalTo(leftContainer).offset(-Constants.UI.groupAutolayout)
    //            make.left.bottom.equalTo(leftContainer)
    //        }
    //    }
    
    //    func viewInit() {
    ////        self.view.frame.size.width = BoxSizeManager.shared.size.width
    ////        self.view.frame.size.height = BoxSizeManager.shared.size.height
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
            return CGFloat(312).pointsToPixels()
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

extension BoxBaseContainerViewController: BoxFunctionViewControllerDelegate {
    func didTapBoxButton() {
        clickBtn(sender: "box")
    }
}
class HoverColorButton: NSButton {
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        // 버튼의 기본 상태 색상 설정
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.blue.cgColor
        self.layer?.cornerRadius = 5.0
        
        // NSTrackingArea 생성
        let trackingArea = NSTrackingArea(rect: self.bounds,
                                          options: [.mouseEnteredAndExited, .activeInActiveApp],
                                          owner: self,
                                          userInfo: nil)
        self.addTrackingArea(trackingArea)
    }
    
    override func mouseEntered(with event: NSEvent) {
        // 호버 상태일 때의 색상 설정
        self.layer?.backgroundColor = NSColor.red.cgColor
    }
    
    override func mouseExited(with event: NSEvent) {
        // 기본 상태 색상으로 복원
        self.layer?.backgroundColor = NSColor.blue.cgColor
    }
}



extension BoxBaseContainerViewController: NSTableViewDelegate {
    // Validate drop operation to allow rearranging of rows
    func tableView(_ aTableView:NSTableView,
                   validateDrop info:NSDraggingInfo,
                   proposedRow row:Int,
                   proposedDropOperation dropOperation:NSTableView.DropOperation) -> NSDragOperation {
        
        if dropOperation == .above {
            return .move
        } else {
            return []
        }
    }
    
    // Handle actual drop operation to rearrange rows
    func tableView(_ aTableView:NSTableView,
                   acceptDrop info:NSDraggingInfo,
                   row:Int,
                   dropOperation:NSTableView.DropOperation) -> Bool {
        
        guard let item = info.draggingPasteboard.pasteboardItems?.first,
              let theString = item.string(forType: .string),
              let index = buttonTitleArray.firstIndex(of: theString)
        else { return false }
        
        aTableView.beginUpdates()
        
        buttonTitleArray.remove(at:index)
        
        if(row < aTableView.numberOfRows){
            buttonTitleArray.insert(theString, at:(row > index ? row-1 : row))
        } else {
            buttonTitleArray.append(theString)
        }
        
        aTableView.endUpdates()
        
        return true
    }
}

class ButtonTableCellView: NSTableCellView {
    var button: NSButton!
    var deleteButton: NSButton!
    var rowIndex: Int!
    
}

extension BoxBaseContainerViewController: NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return buttonTitleArray.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = ButtonTableCellView()
        cellView.rowIndex = row
        
        
        let button = NSButton(title: buttonTitleArray[row], target: self, action: #selector(buttonClicked(_:)))
        
        button.tag = row
        button.bezelStyle = .inline
        cellView.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        let image = NSImage(named: NSImage.Name("bookmark-default"))
        image?.size = NSSize(width: 21, height: 21)
        button.image = image
        button.imagePosition = .imageLeading
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize: 18, weight: .light),
            .foregroundColor: NSColor.black
        ]
        let attributedTitle = NSAttributedString(string: button.title, attributes: attributes)
        button.attributedTitle = attributedTitle
        
        let cell = tableView.view(atColumn: 0, row: row, makeIfNecessary: true)
        if let cell = cell as? ButtonTableCellView {
            cell.addSubview(button)
        }
        
        tableView.rowHeight = 54
        
        return cellView
    }
    
    @objc func buttonClicked(_ sender: NSButton) {
        let tag = sender.tag
        if tag < urlArray.count {
            if let url = URL(string: urlArray[tag]) {
                contentGroup.showWebviews(sender)
            }
        }
    }
    
    // Provide the pasteboard writer for the row (for dragging operation)
    func tableView(_ tableView: NSTableView, pasteboardWriterForRow row: Int) -> NSPasteboardWriting? {
        let pasteboardItem = NSPasteboardItem()
        pasteboardItem.setString(buttonTitleArray[row], forType: .string)
        
        return pasteboardItem
    }
}
