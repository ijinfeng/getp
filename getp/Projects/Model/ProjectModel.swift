//
//  ProjectModel.swift
//  getp
//
//  Created by niren on 2023/4/4.
//

import Foundation


enum ProjectType {
    case unknown
    case apple
    case flutter
    case web
}

enum FileType {
    case unknown
    case file
    case directory
    case project
}

class ProjectModel {
    var name: String?
    var path: String?
    var ptype: ProjectType = .unknown
    var ftype: FileType = .unknown
}
