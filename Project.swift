//
//  Project.swift
//  Config
//
//  Created by Chan on 2023/08/16.
//

import ProjectDescription

// MARK: Constants
let projectName = "Box42"
let organizationName = "Box42"
let bundleID = "com.box42"
let targetVersion = "10.15"
let dependencies: [TargetDependency] = [
    .external(name: "SnapKit"),
]
// MARK: Struct
let project = Project(
  name: projectName,
  organizationName: organizationName,
  packages: [],
  settings: nil,
  targets: [
	Target(name: projectName,
		   platform: .macOS,
		   product: .app,
		   bundleId: bundleID,
		   deploymentTarget: .macOS(targetVersion: targetVersion),
		   infoPlist: .file(path: "\(projectName)/Resources/Info.plist"),
		   sources: ["\(projectName)/**"],
		   resources: ["\(projectName)/Resources/Assets.xcassets",
					   "\(projectName)/Resources/Main.storyboard",
             "\(projectName)/Resources/sh/*.sh",],
		   entitlements: "\(projectName)/Resources/Box42.entitlements",
		   dependencies: dependencies
		  )
  ],
  schemes: [],
  fileHeaderTemplate: nil,
  additionalFiles: [],
  resourceSynthesizers: []
)
