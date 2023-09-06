//
//  Scripts.swift
//  Box42
//
//  Created by Chanhee Kim on 8/11/23.
//

import Foundation

struct Scripts: Codable {
    var info: [Script]
}

struct Script: Codable {
    var scriptUuid: UUID
    var name: String
    var description: String?
    var path: String
    var savedId: Int?
    var userUuid: String?
    
    init(scriptUuid: UUID, name: String, description: String?, path: String, savedId: Int?, userUuid: String?) {
        self.scriptUuid = scriptUuid
        self.name = name
        self.description = description
        self.path = path
        self.savedId = savedId
        self.userUuid = userUuid
    }
}
