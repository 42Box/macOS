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
    
    init(name: String, description: String) {
        self.id = UUID()
        self.name = name
        self.description = description
    }
}
