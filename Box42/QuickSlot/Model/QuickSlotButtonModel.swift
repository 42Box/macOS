//
//  QuickSlotButtonModel.swift
//  Box42
//
//  Created by Chanhee Kim on 8/27/23.
//

import Foundation

struct QuickSlotModels: Codable {
    let quickSlotList : [QuickSlotButtonModel]
}

// Model
struct QuickSlotButtonModel: Codable {
    let scriptUuid: UUID
    var title: String
    var path: String?
    var type: String?
    
    init(id: UUID = UUID(), title: String = "Default", path: String? = "none", type: String = "sh") {
        self.scriptUuid = id
        self.title = title
        self.path = path
        self.type = type
    }
}
