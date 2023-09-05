//
//  ToolbarViewController.swift
//  Box42
//
//  Created by Chanhee Kim on 8/18/23.
//

import Cocoa

class ToolbarViewController: NSViewController {
    override func loadView() {
        let toolbarViewGroup = BoxToolbarViewGroup()
        
        toolbarViewGroup.sidebar = sidebar
        toolbarViewGroup.goBack = goBack
        toolbarViewGroup.goFoward = goFoward
        toolbarViewGroup.reloadPage = reloadPage
        toolbarViewGroup.goToHome = goToHome
        
        self.view = toolbarViewGroup
    }
    var baseContainerVC: BoxBaseContainerViewController?
    var toolbarViewGroup: BoxToolbarViewGroup?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toolbarViewGroup = BoxToolbarViewGroup()
        toolbarViewGroup?.sidebar = sidebar
        
    }
    
    //    func runPrefsHelperApplication() {
    //        let prefsHelperAppPath = "/Users/daskim/Downloads/prefsHelper.app" // prefsHelper.app의 경로
    //
    //        let appURL = URL(fileURLWithPath: prefsHelperAppPath)
    //
    //        let workspace = NSWorkspace.shared
    //        do {
    //            try workspace.open([appURL], withAppBundleIdentifier: nil, options: [], additionalEventParamDescriptor: nil, launchIdentifiers: nil)
    //        } catch {
    //            print("Error opening app: \(error)")
    //        }
    //    }
    
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
        //         print("sidebar")
        //         BookmarkViewModel.shared.addBookmark(item: URLItem(name: "chan", url: "https://42box.kr/"))
        toolbarViewGroup = BoxToolbarViewGroup()
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
                    make.leading.equalToSuperview().inset(10)
                    make.left.bottom.equalTo(baseContainerVC.leftView)
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
            
            // 제약 조건을 다시 설정
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
