//
//  ExcuteScripts.swift
//  Box42
//
//  Created by Chanhee Kim on 8/29/23.
//

import Foundation

class ExcuteScripts {
    static func executeShellScript(path: String) {
        let task = Process()
        task.launchPath = "/bin/sh"
        task.arguments = [path]
        task.launch()
    }
}
