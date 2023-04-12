//
//  ProjectModel.swift
//  getp
//
//  Created by niren on 2023/4/4.
//

import Foundation


enum ProjectType {
    case other
    case apple
    case flutter
}

enum FileType {
    case file
    case directory
}

class ProjectModel {
    let name: String
    let path: String
    var remark: String?
    private(set) var  ptype: ProjectType = .other
    private(set) var  ftype: FileType = .file
    
    init(path: String) {
        self.path = path
        // check project type and file type
        self.name = path.baseName
        let isDir = path.isDirectory
        if (isDir) {
            self.ftype = .directory
        } else {
            self.ftype = .file
        }
        let subpaths = path.subPaths
        for subpath in subpaths {
            if subpath.isAppleProject {
                self.ptype = .apple
                break
            } else if subpath.isFlutterProject {
                self.ptype = .flutter
                break
            }
        }
    }
}


