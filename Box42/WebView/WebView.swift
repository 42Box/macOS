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
        
        contentController.add(self, name: WebViewUI.transfer.deleteScript)
        contentController.add(self, name: WebViewUI.transfer.executeScript)
        contentController.add(self, name: WebViewUI.transfer.downloadScript)
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
        
        // 아이콘 정보 PUT:
        if message.name == WebViewUI.transfer.icon, let imgIconString = message.body as? String {
            icon.buttonImageChange(imgIconString)
        }
        //  유저 정보 (Front)GET: https://api.42box.kr/user-service/users/me
        if message.name == WebViewUI.transfer.userProfile, let userProfileString = message.body as? String {
            let userProfileJson = userProfileString.data(using: .utf8)
            
            print(">>> FrontEnd Get", userProfileString)
            
            do {
                let decoder = JSONDecoder()
                let userProfile = try decoder.decode(UserProfile.self, from: userProfileJson!)
                
                UserManager.shared.updateUserProfile(newProfile: userProfile)

            } catch {
                print("JSON decoding failed: \(error)")
            }
        }
        
        // 스크립트 다운로드
        if message.name == WebViewUI.transfer.downloadScript, let downloadScriptString = message.body as? String {
            let scriptJson = downloadScriptString.data(using: .utf8)
            print("스크립트 다운로드", String(data: scriptJson!, encoding: .utf8) ?? "Invalid JSON data")
            
            do {
                let decoder = JSONDecoder()
                let downloadString = try decoder.decode(Script.self, from: scriptJson!)
                
                ScriptViewModel.shared.addScript(id: UUID(), name: downloadString.name, description: downloadString.description ?? "description", path: downloadString.path, savedId: Int(downloadString.savedId ?? 0), userUuid: downloadString.userUuid!)
                
                print(downloadString)

            } catch {
                print("JSON decoding failed: \(error)")
            }
        }
        
        // 스크립트 실행
        if message.name == WebViewUI.transfer.executeScript, let executeScriptString = message.body as? String {
            let scriptJson = executeScriptString.data(using: .utf8)
            print("스크립트 실행", String(data: scriptJson!, encoding: .utf8) ?? "Invalid JSON data")
            
            do {
                let decoder = JSONDecoder()
                let executeScript = try decoder.decode(Script.self, from: scriptJson!)
                print(String(data: scriptJson!, encoding: .utf8) ?? "Invalid JSON data")
                
                print(executeScript)
                
                ScriptsFileManager.downloadFile(from: "https://42box.kr/" + executeScript.path)
            } catch {
                print("JSON decoding failed: \(error)")
            }
        }
        
        // 스크립트 삭제
        if message.name == WebViewUI.transfer.deleteScript, let deleteScriptString = message.body as? String {
            let scriptJson = deleteScriptString.data(using: .utf8)
            print("스크립트 삭제", String(data: scriptJson!, encoding: .utf8) ?? "Invalid JSON data")
            
            do {
                let decoder = JSONDecoder()
                let deleteScript = try decoder.decode(Script.self, from: scriptJson!)
                print(String(data: scriptJson!, encoding: .utf8) ?? "Invalid JSON data")
                
                print(deleteScript)
                
                ScriptViewModel.shared.deleteScript(id: deleteScript.scriptUuid!)
            } catch {
                print("JSON decoding failed: \(error)")
            }
        }
    }
}
