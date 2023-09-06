//
//  ScriptViewModel.swift
//  Box42
//
//  Created by Chanhee Kim on 8/28/23.
//

import AppKit
import Combine

class ScriptViewModel: NSObject {
    static let shared = ScriptViewModel()
    
    @Published var scripts: [Script] = []
    
    private override init() {
        self.scripts = [
            Script(scriptUuid: UUID(uuidString: "37a56076-e72c-4efe-ba7f-de0effe7f4c3"),
                   name: "CleanCache",
                   description: "Cleaning cache",
                   path: Bundle.main.path(forResource: "cleanCache", ofType: "sh") ?? "", savedId: -1 , userUuid: nil),
            //            Script(name: "brewInGoinfre",
            //                   description: "Brew download in goinfre",
            //                   path: Bundle.main.path(forResource: "brewInGoinfre", ofType: "sh") ?? "", savedId: -1, userUuid: nil),
            //            Script(name: "exportMacOSInfo",
            //                   description: "export setting MacOS Info",
            //                   path: Bundle.main.path(forResource: "exportMacOSInfo", ofType: "sh") ?? "", savedId: -1, userUuid: nil),
            //            Script(name: "importMacOSInfo",
            //                   description: "import MacOS Info",
            //                   path: Bundle.main.path(forResource: "importMacOSInfo", ofType: "sh") ?? "", savedId: -1, userUuid: nil),
            //            Script(name: "key Mapping",
            //                   description: "key Mapping",
            //                   path: Bundle.main.path(forResource: "keyMapping", ofType: "sh") ?? "", savedId: -1, userUuid: nil),
            //            Script(name: "nodeInstall",
            //                   description: "node Install",
            //                   path: Bundle.main.path(forResource: "nodeInstall", ofType: "sh") ?? "", savedId: -1, userUuid: nil)
        ]
        API.initializeUserMeScripts(WebViewManager.shared.getCookieWebKit)
    }
    
    // Create
    func addScript(scriptUuid: UUID?, name: String, description: String?, path: String, savedId: Int?, userUuid: String?) {
        let newScript = Script(scriptUuid: scriptUuid, name: name, description: description, path: path, savedId: savedId, userUuid: userUuid)
        scripts.append(newScript)
    }
    
    //    // Read
    //    func excuteScript(id: UUID) {
    //        if let index = scripts.firstIndex(where: { $0.scriptUuid == id }) {
    //            // MARK: - 파일스크립트 매니저에서 권한을 얻은 실행으로 실행합니다.
    //            ScriptsFileManager.downloadFile(from: "https://42box.kr/" + scripts[index].path)
    //        }
    //    }
    
    // Read
    func excuteScript(path: String) {
        if scripts.firstIndex(where: { $0.path == path }) != nil {
            // MARK: - 파일스크립트 매니저에서 권한을 얻은 실행으로 실행합니다.
            ScriptsFileManager.downloadFile(from: "https://42box.kr/" + path)
        }
    }
    
    // Update
    func updateScript(id: UUID, newName: String, newDescription: String) {
        if let index = scripts.firstIndex(where: { $0.scriptUuid == id }) {
            scripts[index].name = newName
            scripts[index].description = newDescription
        }
    }
    
    // Delete
    func deleteScript(id: UUID?) {
        if let script = scripts.first(where: { $0.scriptUuid == id }) {
            API.deleteUserMeScripts(WebViewManager.shared.getCookieWebKit, savedId: script.savedId!) { result in
                switch result {
                case .success(_):
                    self.scripts.removeAll(where: { $0.scriptUuid == id })
                    if let scriptUuid = id {
                        QuickSlotViewModel.shared.removeButton(scriptUuid)
                    }
                    
                case .failure(let error):
                    print("Failed to delete script: \(error)")
                }
            }
        }
    }
    
    // Delete
    func deleteScript(path: String) {
        self.scripts.removeAll(where: { $0.path == path })
//        if let script = scripts.first(where: { $0.path == path }) {
//            API.deleteUserMeScripts(WebViewManager.shared.getCookieWebKit, savedId: script.savedId!) { result in
//                switch result {
//                case .success(_):
//                    self.scripts.removeAll(where: { $0.path == path })
//                    QuickSlotViewModel.shared.removeButton(path)
//
//                case .failure(let error):
//                    print("Failed to delete script: \(error)")
//                }
//            }
//        }
    }
    
    // 새로운 스크립트 배열로 교체하는 메소드
    func replaceScripts(with newScripts: [Script]) {
        self.scripts = newScripts
    }
    
    // VM class 시작시 최초 1회 실행되는 메소드
    func setupScripts(with newScripts: [Script]) {
        self.scripts = newScripts
    }
    
    // 스크립트안에서 해당하는 스크립트를 찾아서 quickslotVM에 추가
    func quickSlotScript(id: UUID) {
        if let index = scripts.firstIndex(where: { $0.scriptUuid == id }) {
            let button = QuickSlotButtonModel(scriptUuid: id, title: scripts[index].name, path: scripts[index].path)
            QuickSlotViewModel.shared.addButton(button)
        }
    }
    
    // 스크립트안에서 해당하는 스크립트를 찾아서 quickslotVM에 추가
    func quickSlotScript(path: String) {
        if let index = scripts.firstIndex(where: { $0.path == path }) {
            let button = QuickSlotButtonModel(scriptUuid: scripts[index].scriptUuid, title: scripts[index].name, path: scripts[index].path)
            QuickSlotViewModel.shared.addButton(button)
        }
    }
}
