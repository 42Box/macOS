//
//  WebViewModel.swift
//  Box42
//
//  Created by Chan on 2023/03/19.
//

import WebKit

// Singleton
class WebViewList {
	static let shared = WebViewList()

	var list: [String : WKWebView]!
	
	private init() {
		list = [:]
	}
}

// CRUD 4가지 형태의 데이터 가공 create, read, update, delete
class WebViewModel: ObservableObject {
    var webViewURL: URLModels
    @Published var URLdict: [String: URL]

    init() {
        self.webViewURL = URLModels(info: [URLModel(name: "home", url: "https://42box.github.io/front-end/")])
        self.URLdict = [String: URL]()
    }
    
    func setUpURLdict() {
//        for urlModel in webViewURL.info {
//            URLdict[urlModel.name] = URL(string: urlModel.url)
//        }
        for urlModel in webViewURL.URLstring {
            URLdict[urlModel.0] = URL(string: urlModel.1)
        }
    }
    
    
}

