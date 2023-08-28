//
//  BoxBaseContainerViewController.swift
//  Box42
//
//  Created by Chan on 2023/03/17.
//

import Cocoa
import SnapKit

class BoxBaseContainerViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    //    var splitView: BoxBaseSplitView = BoxBaseSplitView()
    var contentGroup: BoxContentsViewGroup = BoxContentsViewGroup()
    var toolbarGroupVC: ToolbarViewController = ToolbarViewController()
    var quickSlotGroupVC: QuickSlotViewController = QuickSlotViewController()
    var functionGroupVC: BoxFunctionViewController = BoxFunctionViewController()
    let windowViewGroupVC: WindowButtonViewController = WindowButtonViewController()
    //    var leftContainer: MovableContainerView = MovableContainerView()
    var buttonGroupVC: ButtonGroupViewController = ButtonGroupViewController()
    
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
    
    @objc func buttonClicked(_ sender: NSButton) {
        if let url = URL(string: "https://www.naver.com") {
            let request = URLRequest(url: url)
            // webview와 연동
        }
    }
    
    func numberOfRows(in tableView:NSTableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView:NSTableView,
                   viewFor tableColumn:NSTableColumn?,
                   row:Int) -> NSView? {
        let cell = NSTableCellView()
        
        let button = NSButton()
        button.title = "Button \(row)"
        button.action = #selector(buttonClicked(_:))
        button.target = self
        
        cell.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.width.equalTo(268)
            make.height.equalTo(44)
            make.center.equalTo(cell)
        }
        
        button.wantsLayer = true
        button.layer?.backgroundColor = NSColor.purple.cgColor
        button.layer?.cornerRadius = 12
        
        return cell
    }
    
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
        let button = NSButton(image: buttonImage, target: self, action: #selector(addCellButtonClicked(_:)))
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
        
        // Create the table view
        let tableView = NSTableView()
        tableView.wantsLayer=true
        tableView.layer?.backgroundColor=NSColor.purple.cgColor
        // Configure the table view...
        
        // Add views to the left view
        bookMarkView.addSubview(stackView)
        bookMarkView.addSubview(tableView)
    
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18) // Place at the top
            make.width.equalToSuperview()
            make.height.equalTo(24)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(0)
            make.width.height.equalToSuperview()
        }
        
        //        buttonGroup = BoxButtonViewGroupInit()
        
        
        //        let stackView = NSStackView()
        //        stackView.orientation = .horizontal
        //        stackView.distribution = .fill
        //        stackView.spacing = 8  // 간격 설정
        //
        //        // 이미지 추가
        //        let imageView = NSImageView(image: NSImage(named: "bookmark")!)  // 적절한 이미지명 사용
        //        imageView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        //        stackView.addView(imageView, in: .leading)
        //
        //        // 라벨 추가
        //        let label = NSTextField(labelWithString: "북마크")
        //        label.font = NSFont.boldSystemFont(ofSize: 16)
        //        label.textColor = NSColor.black
        //        label.backgroundColor = NSColor(hex: "#E7E7E7")
        //        label.isBezeled = false
        //        label.drawsBackground = true
        //        stackView.addView(label, in: .leading)
        //
        //        // +버튼 추가
        //        let button = NSButton(title: "+", target: nil, action: nil)  // 적절한 타겟과 액션 설정
        //        stackView.addView(button, in: .trailing)
        //
        //        bookMarkView.addSubview(stackView)
        //        stackView.wantsLayer = true
        //        stackView.layer?.backgroundColor=NSColor.blue.cgColor
        //        stackView.snp.makeConstraints { (make) in
        //            // 적절한 제약 조건 설정 - 예를 들어, 여기에서는 북마크뷰의 센터에 스택뷰를 위치시킴
        //            make.top.equalTo(bookMarkView)
        //            make.leading.equalTo(bookMarkView)
        //            make.trailing.equalTo(bookMarkView)
        //
        //            make.height.equalTo(30)
        //        }
        //
        //        let tableView = NSTableView()
        //        let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: "column"))
        //        column.width = 268
        //
        //        tableView.rowHeight = 44  // Set the height of each row.
        //        tableView.addTableColumn(column)
        //
        //        tableView.dataSource = self
        //        tableView.delegate = self
        //
        //
        //
        //        bookMarkView.addSubview(label)
        //        bookMarkView.addSubview(tableView)
        //
        ////        label.snp.makeConstraints { make in
        ////            make.top.equalTo(bookMarkView)
        ////            make.leading.equalTo(bookMarkView)
        ////            make.trailing.equalTo(bookMarkView)
        ////
        ////            make.height.equalTo(30)
        ////        }
        //
        //        tableView.snp.makeConstraints { make in
        //            make.top.equalTo(label.snp.bottom)
        //            make.bottom.equalTo(bookMarkView)
        //            make.leading.equalTo(bookMarkView)
        //            make.trailing.equalTo(bookMarkView)
        //
        //        }
    }
    
    @objc func addCellButtonClicked(_ sender: NSButton) {
        // Handle adding a cell to the table view
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
        //        clickBtn(sender: "box")
    }
}
