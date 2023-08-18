//
//  BoxBaseContainerViewController.swift
//  Box42
//
//  Created by Chan on 2023/03/17.
//

import Cocoa
import SnapKit

class BoxBaseContainerViewController: NSViewController {
    var splitView: BoxBaseSplitView! = BoxBaseSplitView()
    var contentGroup: BoxContentsViewGroup! = BoxContentsViewGroup()
    var toolbarGroup: BoxToolbarViewGroup! = BoxToolbarViewGroup()
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
        if sender.title == "Preferences" {
            contentGroup.removeAllSubviews()
            contentGroup.showPreferences()
            return
        }
        if clickCount == 2 {
            WebViewList.shared.list[sender.title]!.reload()
            print("Dobule Click")
        } else if clickCount > 2 {
            //            let rqURL = URLRequest(url: boxVM.URLdict[sender.title]!)
            //            WebViewList.shared.list[sender.title]!.load(rqURL)
            print("Triple Click")
        } else if clickCount < 2 {
            contentGroup.removeAllSubviews()
            contentGroup.showWebviews(sender)
        }
    }
    
    private func leftContainerInit() {
        leftContainer = MovableContainerView()
        leftContainer.addSubview(buttonGroup)
        leftContainer.addSubview(toolbarGroup)
    }
    
    func viewInit() {
        self.boxViewSizeInit()
        
        splitView.addArrangedSubview(leftContainer)
        splitView.addArrangedSubview(contentGroup)
        self.view.addSubview(splitView)
        
        splitView.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(Constants.UI.GroupAutolayout)
            make.bottom.equalTo(self.view).offset(-Constants.UI.GroupAutolayout)
            make.left.equalTo(self.view).offset(Constants.UI.GroupAutolayout)
            make.right.equalTo(self.view).offset(-Constants.UI.GroupAutolayout)
        }
        
        toolbarGroup.snp.makeConstraints { make in
            make.top.equalTo(leftContainer).offset(Constants.UI.GroupAutolayout)
            make.left.right.equalTo(leftContainer)
        }
        
        buttonGroup.snp.makeConstraints { make in
            make.top.equalTo(toolbarGroup.snp.bottom).offset(Constants.UI.GroupAutolayout)
            make.left.right.bottom.equalTo(leftContainer)
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
}
