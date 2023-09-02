//
//  QuickSlotButtonModel.swift
//  Box42
//
//  Created by Chanhee Kim on 8/27/23.
//

import Foundation

// Model
struct QuickSlotButtonModel: Codable {
    let id: UUID
    var title: String
    var path: String?
    
    init(id: UUID = UUID(), title: String = "Default", path: String? = nil) {
        self.id = id
        self.title = title
        self.path = path
    }
}
