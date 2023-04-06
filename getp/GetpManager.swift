//
//  GetpManager.swift
//  getp
//
//  Created by niren on 2023/4/4.
//

import Foundation


enum GetpCase: Int {
case project = 1
case tool
}


class GetpManager {
    static let shared = GetpManager()
    
    private init() {}
    
    var pcase: GetpCase = .project {
        didSet {
            if pcase == .project {
                projectHanlder.loadProjects()
            } else if pcase == .tool {
                
            }
        }
    }
    
    let projectHanlder = ProjectsHandler()
}
