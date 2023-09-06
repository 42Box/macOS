//
//  ToolbarViewController.swift
//  Box42
//
//  Created by Chanhee Kim on 8/18/23.
//

import Cocoa

class ToolbarViewController: NSViewController {
    var baseContainerVC: BoxBaseContainerViewController?
    var toolbarViewGroup: BoxToolbarViewGroup?
    
    override func loadView() {
        let toolbarViewGroup = BoxToolbarViewGroup()
        
        toolbarViewGroup.sidebar = sidebar
        toolbarViewGroup.goBack = goBack
        toolbarViewGroup.goFoward = goFoward
        toolbarViewGroup.reloadPage = reloadPage
        toolbarViewGroup.goToHome = goToHome
        
        self.view = toolbarViewGroup
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toolbarViewGroup = BoxToolbarViewGroup()
        toolbarViewGroup?.sidebar = sidebar
    }
    
    lazy var sidebarLeading: SideBarLeading = SideBarLeading(image: NSImage(imageLiteralResourceName: "toggle-on"), completion: { [weak self] in self?.sidebar() })
    lazy var pinButton: PinButtonView = PinButtonView(title: "", image: NSImage(imageLiteralResourceName: "pin-box"), completion: { StateManager.shared.togglePin()
        
        let newImage: NSImage
        if StateManager.shared.pin {
            newImage = NSImage(imageLiteralResourceName: "pin-box-ver")
        } else {
            newImage = NSImage(imageLiteralResourceName: "pin-box")
        }
        
        self.pinButton.changePinImage(to: newImage)
    })
    
    func sidebar() {
        if let baseContainerVC = baseContainerVC {
            baseContainerVC.leftView.isHidden.toggle()
            
            if baseContainerVC.leftView.isHidden {
                baseContainerVC.contentGroup.snp.remakeConstraints { make in
                    make.top.bottom.trailing.equalToSuperview().inset(12)
                    make.leading.equalToSuperview().offset(24 + 24)
                }
                
                baseContainerVC.view.addSubview(sidebarLeading)
                sidebarLeading.snp.makeConstraints { make in
                    make.top.equalToSuperview().inset(63)
                    make.leading.equalToSuperview().inset(12)
                    make.width.equalTo(24)
                    make.height.equalTo(24)
                }
                
                baseContainerVC.view.addSubview(pinButton)
                pinButton.snp.makeConstraints { make in
                    make.leading.equalToSuperview().offset(-20)
                    make.bottom.equalTo(baseContainerVC.leftView)
                    make.width.equalTo(FunctionButtonUI.size.pinWidth)
                    make.height.equalTo(FunctionButtonUI.size.pinHeight)
                }
            } else {
                baseContainerVC.contentGroup.snp.remakeConstraints { make in
                    make.top.bottom.trailing.equalToSuperview().inset(12)
                    make.leading.equalTo(baseContainerVC.leftView.snp.trailing)
                }
                sidebarLeading.removeFromSuperview()
                pinButton.removeFromSuperview()
            }
            baseContainerVC.view.layoutSubtreeIfNeeded()
        }
    }
    
    func goBack() {
        WebViewManager.shared.hostingWebView?.goBack()
    }
    
    func goFoward() {
        WebViewManager.shared.hostingWebView?.goForward()
    }
    
    func reloadPage() {
        WebViewManager.shared.hostingWebView?.reload()
    }
    
    func goToHome() {
        if let item = WebViewManager.shared.hostingWebView?.backForwardList.backList.first {
            WebViewManager.shared.hostingWebView?.go(to: item)
        }
    }
}
