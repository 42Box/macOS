import ProjectDescription

// MARK: Constants
let projectName = "Box42"
let organizationName = "Box42"
let bundleID = "com.box42"
let targetVersion = "10.15"

// MARK: Struct
let project = Project(
  name: projectName,
  organizationName: organizationName,
  packages: [],
  settings: nil,
  targets: [
	Target(name: projectName,
		   platform: .macOS,
		   product: .app, // unitTests, .appExtension, .framework, dynamicLibrary, staticFramework
		   bundleId: bundleID,
		   deploymentTarget: .macOS(targetVersion: targetVersion),
		   infoPlist: .file(path: "\(projectName)/Resources/Info.plist"),
		   sources: ["\(projectName)/**"],
		   resources: ["\(projectName)/Resources/Assets.xcassets",
					   "\(projectName)/Resources/Main.storyboard",],
		   entitlements: "\(projectName)/Resources/Box42.entitlements",
		   dependencies: [] // tuist generate할 경우 pod install이 자동으로 실행
		  )
  ],
  schemes: [],
  fileHeaderTemplate: nil,
  additionalFiles: [],
  resourceSynthesizers: []
)
