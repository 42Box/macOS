//
//  LoginViewController.swift
//  Box42
//
//  Created by Chanhee Kim on 8/13/23.
//

import Cocoa

class LoginViewController: NSViewController {
    var loginContainerView: NSView = {
        let loginView = NSView()
        loginView.translatesAutoresizingMaskIntoConstraints = false
        loginView.wantsLayer = true
        loginView.layer?.backgroundColor = NSColor.gray.cgColor
        return loginView
    }()
    
    override init(nibName nibNameOrNil: NSNib.Name?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil) // 여기에서 nibName을 nil로 전달
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = NSView() // 기본 뷰 설정
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        view.addSubview(loginContainerView)

        // loginContainerView가 뷰 컨트롤러의 전체 뷰 영역을 차지하도록 제약 추가
        NSLayoutConstraint.activate([
            loginContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            loginContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
