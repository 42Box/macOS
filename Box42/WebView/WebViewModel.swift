//
//  WebViewModel.swift
//  Box42
//
//  Created by Chan on 2023/03/19.
//

import Combine
import WebKit

typealias URLMapping = [String: URL]

// WebView 관련 CRUD 4가지 형태의 데이터 가공 create, read, update, delete
class WebViewModel: ObservableObject {
    @Published var webViewURL: URLModels
    @Published var URLdict: URLMapping
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.webViewURL = URLModels(info: [URLModel(name: Constants.url.initialName, url: Constants.url.initialPage)])
        self.URLdict = URLMapping()

        $webViewURL.sink { (WVURL) in
            self.setUpURLdict()
        }.store(in: &cancellables)
    }
    
    func setUpURLdict() {
        for urlModel in webViewURL.URLstring {
            URLdict[urlModel.name] = URL(string: urlModel.url)
        }
    }
    
    // Create
    func createURL(_ name: String, _ url: String) {
        let newURL = URLModel(name: name, url: url)
        self.webViewURL.info.append(newURL)
    }
    
    // Read
    func readURLString(_ index: Int) -> URLModel {
        return webViewURL.info[index]
    }
    
    func readURL(_ index: Int) -> URL {
        return URL(string: webViewURL.info[index].url) ?? URL(string: Constants.url.initialPage)!
    }
    
    func safeURL() -> URL {
        return URL(string: webViewURL.info.first?.url ?? Constants.url.initialPage)!
    }
    
    func requestURL(_ url: URL) -> URLRequest {
        return URLRequest(url: url)
    }
    
    // Update
    func updateURL(_ id: UUID, _ name: String, _ url: String) {
        if let selectedIndex = webViewURL.info.firstIndex(where: { user in user.id == id }) {
            webViewURL.info[selectedIndex].name = name
            webViewURL.info[selectedIndex].url = url
        }
    }
    
    // Delete
    func deleteURL(id: UUID) {
        if let selectedIndex = webViewURL.info.firstIndex(where: { user in user.id == id }) {
            cancellables.removeAll()
            webViewURL.info.remove(at: selectedIndex)
        }
    }
    
}

