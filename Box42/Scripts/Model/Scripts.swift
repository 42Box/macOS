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
    var id: UUID
    var name: String
    var description: String
    var path: String
    var savedId: Int
    
    init(name: String, description: String, path: String, savedId: Int) {
        self.id = UUID()
        self.name = name
        self.description = description
        self.path = path
        self.savedId = savedId
    }
}
