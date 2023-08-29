//
//  BoxBaseContainerViewController.swift
//  Box42
//
//  Created by Chan on 2023/03/17.
//

import Cocoa
import SnapKit

class BoxBaseContainerViewController: NSViewController {
    // MARK: - LeftContainer
    var splitView: BoxBaseSplitView = BoxBaseSplitView()
    var contentGroup: BoxContentsViewGroup = BoxContentsViewGroup()
    var toolbarGroupVC: ToolbarViewController = ToolbarViewController()
    var quickSlotGroupVC: QuickSlotViewController = QuickSlotViewController()
    var functionGroupVC: BoxFunctionViewController = BoxFunctionViewController()
    let windowViewGroupVC: WindowButtonViewController = WindowButtonViewController()
    var leftContainer: MovableContainerView = MovableContainerView()
    var buttonGroupVC: ButtonGroupViewController = ButtonGroupViewController()
    
    // MARK: - QuickSlot
    var preferenceVC: PreferencesViewController = PreferencesViewController()
        
    weak var menubarVCDelegate: MenubarViewControllerDelegate? // extension
    
    override func loadView() {
        self.view = NSView()
        self.view.addSubview(splitView)
        splitView.delegate = self
        
//        buttonGroup = BoxButtonViewGroupInit()
        
        leftContainerInit()
        viewInit()
    }
    
    override func viewDidLoad() {
        self.view.wantsLayer = true
//        self.view.layer?.backgroundColor = NSColor(hex: "#FF9548").cgColor
        self.view.layer?.backgroundColor = NSColor(hex: "#E7E7E7").cgColor
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleButtonTapped), name: NSNotification.Name(NotifConst.object.collectionButtonTapped), object: nil)
    }
    
    func BoxButtonViewGroupInit() -> BoxButtonViewGroup {
        
        let buttonGroup = BoxButtonViewGroup { sender in
            self.clickBtn(sender: sender)
        }

        return buttonGroup
    }
    
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
    
    private func leftContainerInit() {
        leftContainer.frame.size.width = BoxSizeManager.shared.windowButtonGroupSize.width
        leftContainer.frame.size.height = BoxSizeManager.shared.windowButtonGroupSize.height
        leftContainer.addSubview(windowViewGroupVC.view)
        leftContainer.addSubview(buttonGroupVC.view)
        leftContainer.addSubview(toolbarGroupVC.view)
        leftContainer.addSubview(quickSlotGroupVC.view)
        leftContainer.addSubview(functionGroupVC.view)

        leftContainerAutolayout()
    }

    private func leftContainerAutolayout() {
        windowViewGroupVC.view.snp.makeConstraints { make in
            make.top.equalTo(leftContainer)
            make.left.equalTo(leftContainer).offset(3)
            make.width.equalTo(77)
            make.height.equalTo(21)
        }
        
        toolbarGroupVC.view.snp.makeConstraints { make in
            make.top.equalTo(windowViewGroupVC.view.snp.bottom).offset(31)
            make.right.equalTo(leftContainer)
            make.left.equalTo(leftContainer)
            make.height.equalTo(44 + 14 + 24)
        }
        
        buttonGroupVC.view.snp.makeConstraints { make in
            make.top.equalTo(toolbarGroupVC.view.snp.bottom).offset(Constants.UI.groupAutolayout)
            make.right.equalTo(leftContainer).offset(-Constants.UI.groupAutolayout)
            make.left.equalTo(leftContainer)
            make.bottom.equalTo(quickSlotGroupVC.view.snp.top).offset(-Constants.UI.groupAutolayout)
        }
        
       quickSlotGroupVC.view.snp.makeConstraints { make in
           make.bottom.equalTo(functionGroupVC.view.snp.top).offset(-27)
           make.right.equalTo(leftContainer).offset(-Constants.UI.groupAutolayout)
           make.left.equalTo(leftContainer)
           make.height.equalTo(178)
       }
        
        functionGroupVC.view.snp.makeConstraints { make in
            make.right.equalTo(leftContainer).offset(-Constants.UI.groupAutolayout)
            make.left.bottom.equalTo(leftContainer)
        }
    }
    
    func viewInit() {
        self.boxViewSizeInit()
        
        splitView.addArrangedSubview(leftContainer)
        splitView.addArrangedSubview(contentGroup)
        self.view.addSubview(splitView)
        
        splitView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Constants.UI.groupAutolayout)
            make.left.equalToSuperview().offset(Constants.UI.groupAutolayout)
            make.right.equalToSuperview().offset(-Constants.UI.groupAutolayout)
            make.bottom.equalToSuperview().offset(-Constants.UI.groupAutolayout)
        }
    }
    
    func boxViewSizeInit() {
        self.view.frame.size.width = BoxSizeManager.shared.size.width
        self.view.frame.size.height = BoxSizeManager.shared.size.height
    }
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

        let leftWidth = leftContainer.frame.width
        let contentWidth = newWidth - leftWidth

        leftContainer.frame = NSRect(x: 0, y: 0, width: leftWidth, height: splitView.bounds.height)
        contentGroup.frame = NSRect(x: leftWidth + dividerThickness, y: 0, width: contentWidth, height: splitView.bounds.height)
    }
}

extension BoxBaseContainerViewController: BoxFunctionViewControllerDelegate {
    func didTapBoxButton() {
        clickBtn(sender: "box")
    }
}

extension BoxBaseContainerViewController {
    @objc func handleButtonTapped(notification: NSNotification) {
        if let button = notification.object as? NSButton {
            if button.title == QuickSlotUI.title.preferences {
                print("Button with title \(button.title) was tapped in BaseVC")
                contentGroup.showPreferences()
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
