//
//  displayURLInToolbar.swift
//  Box42
//
//  Created by Chanhee Kim on 8/18/23.
//

import AppKit
import WebKit
import SnapKit

class DisplayURLInToolbar: NSView {
    static let shared = DisplayURLInToolbar()
    
    var URLTextfield: DisplayURLTextfield = DisplayURLTextfield()
    var originalString: String = ""
    
    private override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor(hex: "#7FFFFFFF").cgColor
        self.layer?.cornerRadius = 13
        
        WebViewManager.shared.hostingWebView?.navigationDelegate = self
        
        self.addSubview(URLTextfield)
        textfieldInit()
        textfieldConstraints()
        
        updateURL()
    }
    
    func textfieldInit() {
        URLTextfield.font = NSFont.systemFont(ofSize: 15)
        URLTextfield.maximumNumberOfLines = 1
        URLTextfield.lineBreakMode = .byTruncatingTail
        URLTextfield.isEditable = true
        URLTextfield.isBordered = false
        URLTextfield.backgroundColor = NSColor.clear
        URLTextfield.focusRingType = .none
        URLTextfield.isAutomaticTextCompletionEnabled = false
        URLTextfield.delegate = self
        URLTextfield.onTextFieldRestore = {
            self.URLTextfield.stringValue = self.originalString
        }
    }
    
    func textfieldConstraints() {
        URLTextfield.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(17)
            make.trailing.equalToSuperview().offset(-17)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DisplayURLInToolbar: NSTextFieldDelegate {
    func control(_ control: NSControl, textView: NSTextView, doCommandBy commandSelector: Selector) -> Bool {
        if commandSelector == #selector(insertNewline(_:)) {
            var urlString = URLTextfield.stringValue
            let validateURL = urlString.split(separator: "/").map({String($0)})
            if validateURL.count < 1 {
                return false
            } else if validateURL[0] != "https:" && validateURL[0] != "http:" {
                urlString = "https://" + urlString
            }
            
            if let url = URL(string: urlString) {
                DispatchQueue.main.async {
                    print(url)
                    WebViewManager.shared.hostingWebView?.load(URLRequest(url: url))
                }
            }
            return true
        }
        return false
    }
}

extension DisplayURLInToolbar: WKNavigationDelegate {
    func updateURL() {
        DispatchQueue.main.async {
            if let url = WebViewManager.shared.hostingWebView?.url {
                self.originalString = url.absoluteString
                let showURLString: [String?] = self.originalString.split(separator: "/").map{String($0)}
                if showURLString.count > 1 {
                    self.URLTextfield.stringValue = (showURLString[1] ?? "")
                }
                self.URLTextfield.needsDisplay = true
                self.URLTextfield.display()
            }
            
            print(self.URLTextfield.stringValue)
            print(self.originalString)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Navigation finished")
        updateURL()
    }
}
