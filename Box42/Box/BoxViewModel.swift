//
//  URLViewModel.swift
//  Box42
//
//  Created by Chanhee Kim on 8/9/23.
//

import Foundation
import Combine

// CRUD 4가지 형태의 데이터 가공 create, read, update, delete
class BoxViewModel: ObservableObject {
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
