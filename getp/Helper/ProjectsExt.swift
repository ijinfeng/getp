//
//  ProjectsExt.swift
//  getp
//
//  Created by niren on 2023/4/6.
//

import Foundation

extension String {
    /// 是否是Apple项目
    public var isAppleProject: Bool {
        self.extName == "xcodeproj"
    }
    
    /// 是否是Flutter项目
    public var isFlutterProject: Bool {
        let hasYaml = self.baseName == "pubspec.yaml"
        guard hasYaml else {
            return false
        }
        let fileManager = FileManager.default
        if let data = fileManager.contents(atPath: self) {
            if let dataString = String(data: data, encoding: .utf8) {
                let has = dataString.lowercased().contains("flutter")
                return has
            }
        }
        return false
    }
}
