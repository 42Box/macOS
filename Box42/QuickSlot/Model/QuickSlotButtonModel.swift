//
//  QuickSlotButtonModel.swift
//  Box42
//
//  Created by Chanhee Kim on 8/27/23.
//

import Foundation

// Model
struct QuickSlotButtonModel {
    let id: UUID
    var title: String
    
    init(id: UUID = UUID(), title: String = "Default") {
        self.id = id
        self.title = title
    }
}
