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
    
    override init() {
        self.scripts = [
            Script(name: "cleanCache",
                   description: "Cleaning cache",
                   path: Bundle.main.path(forResource: "cleanCache", ofType: "sh") ?? "", savedId: -1 ),
            Script(name: "brewInGoinfre",
                   description: "Brew download in goinfre",
                   path: Bundle.main.path(forResource: "brewInGoinfre", ofType: "sh") ?? "", savedId: -1),
            Script(name: "exportMacOSInfo",
                   description: "export setting MacOS Info",
                   path: Bundle.main.path(forResource: "exportMacOSInfo", ofType: "sh") ?? "", savedId: -1 ),
            Script(name: "importMacOSInfo",
                   description: "import MacOS Info",
                   path: Bundle.main.path(forResource: "importMacOSInfo", ofType: "sh") ?? "", savedId: -1),
            Script(name: "key Mapping",
                   description: "key Mapping",
                   path: Bundle.main.path(forResource: "keyMapping", ofType: "sh") ?? "", savedId: -1 ),
            Script(name: "nodeInstall",
                   description: "node Install",
                   path: Bundle.main.path(forResource: "nodeInstall", ofType: "sh") ?? "", savedId: -1)
        ]
    }
    
    // Create
    func addScript(name: String, description: String, path: String) {
        let newScript = Script(name: name, description: description, path: path, savedId: -1)
        scripts.append(newScript)
    }
    
    // Read
    func excuteScript(id: UUID) {
        if let index = scripts.firstIndex(where: { $0.id == id }) {
//            ExecuteScripts.executeShellScript(path: scripts[index].name)
            // MARK: - 파일스크립트 매니저에서 권한을 얻은 실행으로 실행합니다.
            SecurityScopedResourceAccess.accessResourceExecuteShellScript(scriptPath: scripts[index].path)
        }
    }
    
    // Update
    func updateScript(id: UUID, newName: String, newDescription: String) {
        if let index = scripts.firstIndex(where: { $0.id == id }) {
            scripts[index].name = newName
            scripts[index].description = newDescription
        }
    }
    
    // Delete
    func deleteScript(id: UUID) {
        // delete 요청 보내야함 보내고 성공하면 지우기
        scripts.removeAll(where: { $0.id == id })
        QuickSlotViewModel.shared.removeButton(id)
    }
    
    // 새로운 스크립트 배열로 교체하는 메서드
    func replaceScripts(with newScripts: [Script]) {
        self.scripts = newScripts
    }
    
    // 스크립트안에서 해당하는 스크립트를 찾아서 quickslotVM에 추가
    func quickSlotScript(id: UUID) {
        if let index = scripts.firstIndex(where: { $0.id == id }) {
            let button = QuickSlotButtonModel(id: id, title: scripts[index].name, path: scripts[index].path)
            QuickSlotViewModel.shared.addButton(button)
        }
    }
}
