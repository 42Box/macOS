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
                        URLItem(name: "loopback", url: "http://127.0.0.1:3000/"),
                        URLItem(name: "Box 42", url: "https://42box.github.io/front-end/#/box"),
                        URLItem(name: "Intra 42", url: "https://intra.42.fr"),
                        URLItem(name: "Jiphyeonjeon", url: "https://42library.kr"),
                        URLItem(name: "42STAT", url: "https://stat.42seoul.kr/home"),
                        URLItem(name: "24Hane", url: "https://24hoursarenotenough.42seoul.kr"),
                        URLItem(name: "80kCoding", url: "https://80000coding.oopy.io"),
                        URLItem(name: "where42", url: "https://www.where42.kr"),
                        URLItem(name: "cabi", url: "https://cabi.42seoul.io/"),
                        URLItem(name: "42gg", url: "https://42gg.kr/")]
    }
    
    // Create
    func addBookmark(item: URLItem) {
        bookMarkList.append(item)
    }
    
    // Read
    func excuteBookmark(path: String) {
    }
    
    // Delete
    func deleteBookmark(byURL url: String) {
        bookMarkList.removeAll(where: { $0.url == url })
    }
    
    // 새로운 스크립트 배열로 교체하는 메소드
    func replaceBookMarkList(with newScripts: [URLItem]) {
        self.bookMarkList = newScripts
    }
}
