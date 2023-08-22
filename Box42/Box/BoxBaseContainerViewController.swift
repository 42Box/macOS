//
//  BoxBaseContainerViewController.swift
//  Box42
//
//  Created by Chan on 2023/03/17.
//

import Cocoa
import SnapKit

class BoxBaseContainerViewController: NSViewController {
    var splitView: BoxBaseSplitView = BoxBaseSplitView()
    var contentGroup: BoxContentsViewGroup = BoxContentsViewGroup()
    var toolbarGroupVC: ToolbarViewController = ToolbarViewController()
    var functionGroupVC: BoxFunctionViewController = BoxFunctionViewController()
    let windowViewGroup: WindowButtonViewController = WindowButtonViewController()
    var buttonGroup: BoxButtonViewGroup!
    var leftContainer: MovableContainerView!

    override func loadView() {
        self.view = NSView()
        self.view.addSubview(splitView)
        splitView.delegate = self
        
        buttonGroup = BoxButtonViewGroupInit()
        
        leftContainerInit()
        viewInit()
    }
    
    func BoxButtonViewGroupInit() -> BoxButtonViewGroup {
        let buttonGroup = BoxButtonViewGroup { sender in
            self.clickBtn(sender: sender)
        }
        return buttonGroup
    }
    
    func clickBtn(sender: NSButton) {
        guard let clickCount = NSApp.currentEvent?.clickCount else { return }
        if clickCount == 2 {
            WebViewManager.shared.list[sender.title]!.reload()
            print("Dobule Click")
        } else if clickCount > 2 {
            if let currentURL = WebViewManager.shared.hostingWebView?.url {
                NSWorkspace.shared.open(currentURL)
            }
            print("Triple Click")
        } else if clickCount < 2 {
            contentGroup.removeAllSubviews()
            contentGroup.showWebviews(sender)
        }
    }
    
    private func leftContainerInit() {
        leftContainer = MovableContainerView()
        leftContainer.addSubview(buttonGroup)
        leftContainer.addSubview(windowViewGroup.view)
        leftContainer.addSubview(toolbarGroupVC.view)
        leftContainer.addSubview(functionGroupVC.view)
        leftContainerAutolayout()
        leftContainer.frame.size.width = BoxSizeManager.shared.windowButtonGroupSize.width
    }

    private func leftContainerAutolayout() {
        windowViewGroup.view.snp.makeConstraints { make in
            make.top.equalTo(leftContainer).offset(Constants.UI.GroupAutolayout)
            make.right.equalTo(leftContainer).offset(-Constants.UI.GroupAutolayout)
            make.left.equalTo(leftContainer)
        }
        
        toolbarGroupVC.view.snp.makeConstraints { make in
            make.top.equalTo(windowViewGroup.view.snp.bottom).offset(Constants.UI.GroupAutolayout)
            make.right.equalTo(leftContainer).offset(-Constants.UI.GroupAutolayout)
            make.left.equalTo(leftContainer)
        }
        
        buttonGroup.snp.makeConstraints { make in
            make.top.equalTo(toolbarGroupVC.view.snp.bottom).offset(Constants.UI.GroupAutolayout)
            make.right.equalTo(leftContainer).offset(-Constants.UI.GroupAutolayout)
            make.left.equalTo(leftContainer)
        }
        
        functionGroupVC.view.snp.makeConstraints { make in
            make.top.equalTo(buttonGroup.snp.bottom).offset(Constants.UI.GroupAutolayout)
            make.right.equalTo(leftContainer).offset(-Constants.UI.GroupAutolayout)
            make.left.bottom.equalTo(leftContainer)
        }
    }
    
    func viewInit() {
        self.boxViewSizeInit()
        
        splitView.addArrangedSubview(leftContainer)
        splitView.addArrangedSubview(contentGroup)
        self.view.addSubview(splitView)
        
        splitView.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(Constants.UI.GroupAutolayout)
            make.left.equalTo(self.view).offset(Constants.UI.GroupAutolayout)
            make.right.equalTo(self.view).offset(-Constants.UI.GroupAutolayout)
            make.bottom.equalTo(self.view).offset(-Constants.UI.GroupAutolayout)
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
            return 132
        }
        return proposedMinimumPosition
    }

    func splitView(_ splitView: NSSplitView, constrainMaxCoordinate proposedMaximumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        if dividerIndex == 0 {
            return 200
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
