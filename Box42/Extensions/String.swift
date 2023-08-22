//
//  String.swift
//  Box42
//
//  Created by Chanhee Kim on 7/8/23.
//

import Foundation

extension String {
    var escapedForJavaScript: String {
        let allowedCharacters = CharacterSet(charactersIn: "\"\\")
        return self.unicodeScalars.map { char -> String in
            if allowedCharacters.contains(char) {
                return String(char)
            } else {
                return String(format: "\\u%04x", char.value)
            }
        }.joined()
    }
}
