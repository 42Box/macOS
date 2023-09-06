//
//  BookmarkViewModel.swift
//  Box42
//
//  Created by Chan on 2023/09/04.
//

import AppKit
import Combine

class BookmarkViewModel: NSObject {
    static let shared = BookmarkViewModel()
    
    @Published var bookMarkList: [URLItem] = []
    
    private override init() {
        self.bookMarkList = [URLItem(name: "42Box", url: "https://42box.kr/"),
                             URLItem(name: "23Coaltheme", url: "https://42box.github.io/front-end/"),
                             URLItem(name: "Intra 42", url: "https://intra.42.fr"),
                             URLItem(name: "Jiphyeonjeon", url: "https://42library.kr"),
                             URLItem(name: "42GG", url: "https://42gg.kr/"),
                             URLItem(name: "42STAT", url: "https://stat.42seoul.kr/home"),
                             URLItem(name: "24Hane", url: "https://24hoursarenotenough.42seoul.kr"),
                             URLItem(name: "80kCoding", url: "https://80000coding.oopy.io"),
                             URLItem(name: "Where42", url: "https://www.where42.kr"),
                             URLItem(name: "Cabi", url: "https://cabi.42seoul.io/"),
              ]}
    
    // Create
    func addBookmarkByFront(item: URLItem) {
        bookMarkList.append(item)
        loadWebView(item.name, item.url)
    }
    
    // Create
    func addBookmark(item: URLItem) {
        bookMarkList.append(item)
        loadWebView(item.name, item.url)
        
        let body = URLList(urlList: bookMarkList)
        API.putUserMeUrlList(urlList: body) { result in
            switch result {
            case .success(_):
                print("Successfully updated the scripts.") // 혹은 사용자에게 보여줄 알림 추가
            case .failure(let error):
                print("Failed to update scripts: \(error.localizedDescription)") // 혹은 사용자에게 보여줄 알림 추가
            }
        }
    }
    
    func updateBookmark(index: Int, item: URLItem) {
        WebViewManager.shared.list[item.name]?.navigationDelegate = nil
        WebViewManager.shared.list[item.name]?.stopLoading()
        WebViewManager.shared.list[item.name] = nil
        bookMarkList[index] = item
        loadWebView(item.name, item.url)
    }
    
    // Delete
    func deleteBookmark(item: URLItem) {
        WebViewManager.shared.list[item.name]?.navigationDelegate = nil
        WebViewManager.shared.list[item.name]?.stopLoading()
        WebViewManager.shared.list[item.name] = nil
        self.bookMarkList.removeAll(where: { $0 == item })
    }
    
    // 새로운 북마크 배열로 교체하는 메소드
    func replaceBookMarkList(with newBookMarkList: [URLItem]) {
        DispatchQueue.main.async {
            WebViewManager.shared.list.forEach { (key, webView) in
                webView.navigationDelegate = nil
                webView.stopLoading()
                WebViewManager.shared.list[key] = nil
            }
        }
        
        newBookMarkList.forEach { (URLItem) in
            loadWebView(URLItem.name, URLItem.url)
        }
        self.bookMarkList = newBookMarkList
    }
    
    
    func loadWebView(_ name: String, _ url: String) {
        var url = url
        if !url.hasPrefix("https://") && !url.hasPrefix("http://")  {
            url = "https://" + url
            print(url)
        }
        if let loadURL = URL(string: url) {
            DispatchQueue.main.async {
                let wkWebView = WebView()
                let request = URLRequest(url: loadURL)
                
                print(request)
                WebViewManager.shared.list[name] = wkWebView
                DispatchQueue.main.async {
                    wkWebView.load(request)
                }
            }
        }
    }
}
