//
//  ProjectModel.swift
//  getp
//
//  Created by niren on 2023/4/4.
//

import Foundation


enum ProjectType: Int {
    case other
    case apple
    case flutter
}

enum FileType: Int {
    case file
    case directory
}

class ProjectModel: CustomDebugStringConvertible {
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
    
    init(mo: ProjectMO) {
        self.name = mo.name ?? ""
        self.path = mo.path ?? ""
        self.remark = mo.remark
        self.ptype = ProjectType.init(rawValue: Int(mo.ptype)) ?? .other
        self.ftype = FileType.init(rawValue: Int(mo.ftype)) ?? .file
    }
    
    var debugDescription: String {
        return "name: \(name)\npath: \(path)\nremark: \(remark ?? "nil")\nptype: \(ptype)\nftype: \(ftype)"
    }
}


