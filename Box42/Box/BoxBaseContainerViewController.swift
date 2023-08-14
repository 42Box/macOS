//
//  BoxBaseContainerViewController.swift
//  Box42
//
//  Created by Chan on 2023/03/17.
//

import Cocoa

class BoxBaseContainerViewController: NSViewController {
    var buttonGroup : BoxButtonViewGroup!
    var contentGroup : BoxContentsViewGroup!
    
    override func loadView() {
        self.view = NSView() // 뷰 컨트롤러의 뷰 설정
        buttonGroup = BoxButtonViewGroupInit()
        contentGroup = BoxContentsViewGroup()
        panGestureInit()
        viewInit()
    }

    func BoxButtonViewGroupInit() -> BoxButtonViewGroup {
        let buttonGroup = BoxButtonViewGroup { sender in
                    // 버튼을 클릭할 때 실행할 코드
            self.clickBtn(sender: sender)
        }
        view.addSubview(buttonGroup)
        return buttonGroup
    }

    func clickBtn(sender: NSButton) {
        guard let clickCount = NSApp.currentEvent?.clickCount else { return }
        if sender.title == "Preferences" {
//            boxView.contentGroup.subviews.removeAll()
//            boxView.contentGroup.addSubview(preferencesVC.view)
//            preferencesVC.viewDidAppear()
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
//            boxView.contentGroup.subviews.removeAll()
//            boxView.contentGroup.addSubview(WebViewList.shared.list[sender.title]!)
            WebViewList.shared.list[sender.title]!.configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
            WebViewList.shared.list[sender.title]!.configuration.preferences.javaScriptEnabled = true
            WebViewList.shared.list[sender.title]?.viewDidMoveToSuperview()
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
        buttonGroup.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonGroup.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            buttonGroup.topAnchor.constraint(equalTo: self.view.topAnchor),
            buttonGroup.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            buttonGroup.widthAnchor.constraint(equalToConstant: BoxSizeManager.shared.buttonGroupSize.width)
        ])

        // contentGroup 오토레이아웃 설정
        contentGroup.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentGroup.leadingAnchor.constraint(equalTo: buttonGroup.trailingAnchor),
            contentGroup.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            contentGroup.topAnchor.constraint(equalTo: self.view.topAnchor),
            contentGroup.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
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
