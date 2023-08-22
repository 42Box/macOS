//
//  Dependencies.swift
//  Config
//
//  Created by Chan on 2023/08/16.
//

import ProjectDescription

let spm = SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/SnapKit/SnapKit", requirement: .exact("5.6.0")),
])

let dependencies = Dependencies(
	swiftPackageManager: spm,
	platforms: [.macOS]
)
