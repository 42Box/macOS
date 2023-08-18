//
//  BoxBaseContainerViewController.swift
//  Box42
//
//  Created by Chan on 2023/03/17.
//

import Cocoa
import SnapKit

class BoxBaseContainerViewController: NSViewController {
    var buttonGroup : BoxButtonViewGroup!
    var contentGroup : BoxContentsViewGroup!
    
    override func loadView() {
        self.view = NSView() // 뷰 컨트롤러의 뷰 설정
        buttonGroup = BoxButtonViewGroupInit()
        contentGroup = BoxContentsViewGroup()
//        panGestureInit()
        viewInit()
    }

    func BoxButtonViewGroupInit() -> BoxButtonViewGroup {
        let buttonGroup = BoxButtonViewGroup { sender in
            self.clickBtn(sender: sender)
        }
        view.addSubview(buttonGroup)
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

    private func panGestureInit() {
        let panRecognizer = NSPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        self.view.addGestureRecognizer(panRecognizer) // 뷰 컨트롤러의 뷰에 제스처 추가
    }
    
    func viewInit() {
        self.boxViewSizeInit()
        self.buttonBoxGroupInit()
        self.contentsGroupInit()
        
        // buttonGroup과 contentGroup을 self에 추가합니다.
        view.addSubview(buttonGroup)
        view.addSubview(contentGroup)

        // buttonGroup 오토레이아웃 설정
        buttonGroup.snp.makeConstraints { make in
            make.leading.equalTo(self.view).offset(Constants.UI.GroupAutolayout)
            make.top.equalTo(self.view).offset(Constants.UI.GroupAutolayout)
            make.bottom.equalTo(self.view).offset(-Constants.UI.GroupAutolayout)
            make.width.equalTo(BoxSizeManager.shared.buttonGroupSize.width)
        }

        // contentGroup 오토레이아웃 설정
        contentGroup.snp.makeConstraints { make in
            make.leading.equalTo(buttonGroup.snp.trailing)
            make.trailing.equalTo(self.view).offset(-Constants.UI.GroupAutolayout)
            make.top.equalTo(self.view).offset(Constants.UI.GroupAutolayout)
            make.bottom.equalTo(self.view).offset(-Constants.UI.GroupAutolayout)
        }
    }

    func boxViewSizeInit() {
        self.view.frame.size.width = BoxSizeManager.shared.size.width
        self.view.frame.size.height = BoxSizeManager.shared.size.height
    }
     
    func contentsGroupInit() {
        self.contentGroup.frame.size.width = BoxSizeManager.shared.size.width - BoxSizeManager.shared.buttonGroupSize.width
        self.contentGroup.frame.size.height = BoxSizeManager.shared.size.height
    }
    
    func buttonBoxGroupInit() {
        self.buttonGroup.frame.size.width = BoxSizeManager.shared.buttonGroupSize.width
        self.buttonGroup.frame.size.height = BoxSizeManager.shared.buttonGroupSize.height
    }
}

extension BoxBaseContainerViewController {
    // 추후 논의. 내부 panGesture로 View크기 증감
    @objc private func handlePanGesture(_ recognizer: NSPanGestureRecognizer) {
        guard let view = recognizer.view else { return }
        
        // 사용자가 드래그한 변화량을 가져옵니다.
        let translation = recognizer.translation(in: view)
        
        // 드래그로 인한 크기 변화를 계산합니다.
        let newWidth = view.frame.width + translation.x
        let newHeight = view.frame.height + translation.y
        
        // 크기를 적용합니다.
        view.setFrameSize(NSSize(width: newWidth, height: newHeight))
        
        // 변화량을 리셋합니다.
        recognizer.setTranslation(.zero, in: view)
        
        print(newWidth, newHeight)
    }
}
