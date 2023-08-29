//
//  WebView.swift
//  Box42
//
//  Created by Chanhee Kim on 8/18/23.
//

import WebKit

class WebView: WKWebView, WKScriptMessageHandler {
    var icon = MenubarViewController()
    
    init() {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let contentController = WKUserContentController()
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.userContentController = contentController
        super.init(frame: .zero, configuration: configuration)
        
        contentController.add(self, name: WebViewUI.transfer.download)
        contentController.add(self, name: WebViewUI.transfer.icon)
        contentController.add(self, name: WebViewUI.transfer.userProfile)
        
        self.configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        self.configuration.preferences.javaScriptEnabled = true
        self.configuration.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        
        self.becomeFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Front Client 통신
extension WebView {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // 스크립트 다운로드
        if message.name == WebViewUI.transfer.download, let downloadURLString = message.body as? String {
            ScriptsFileManager.downloadFile(from: downloadURLString)
        }
        // 아이콘 정보 PUT:
        if message.name == WebViewUI.transfer.icon, let imgIconString = message.body as? String {
            icon.buttonImageChange(imgIconString)
        }
        //  유저 정보 (Front)GET: https://api.42box.site/user-service/users/me
        if message.name == WebViewUI.transfer.userProfile, let userProfileString = message.body as? String {
            let userProfileJson = userProfileString.data(using: .utf8)
            
            print(">>> FrontEnd Get", userProfileString)
            
            do {
                let decoder = JSONDecoder()
                let userProfile = try decoder.decode(UserProfile.self, from: userProfileJson!)
                print(userProfile.icon)
                
                UserManager.shared.updateUserProfile(newProfile: userProfile)

            } catch {
                print("JSON decoding failed: \(error)")
            }
        }
    }
}
