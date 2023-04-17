//
//  ProjectsHandler.swift
//  getp
//
//  Created by niren on 2023/4/4.
//

import Foundation

class ProjectsHandler {
    private var projects: Array<ProjectModel> = []
    
    private var loaded = false
    
    
    public var selectedProject: ProjectModel?
    
    public var projectsCount: Int {
        return projects.count
    }
    
    public func loadProjects(_ block: (([ProjectModel]) -> Void)?) {
        guard !loaded else {
            block?(self.projects)
            return
        }
        let projectDB = ProjectDataBaseManager.shared
        projectDB.load { [weak self] _ in
            self?.loaded = true
            self?.projects = projectDB.readProjects()
            block?(self?.projects ?? [])
        }
    }
    
    /// 添加项目
    /// - Parameter path: 项目路径
    /// - Returns: 是否添加成功，如果列表中已经存在相同路径，添加失败
    @discardableResult
    public func addProject(path: String) -> Bool {
        guard !path.isEmpty else {
            return false
        }
        for project in projects {
            if project.path == path {
                return false
            }
        }
        let model = ProjectModel(path: path)
        projects.append(model)
        let projectDB = ProjectDataBaseManager.shared
        projectDB.insertNewProject(project: model)
        return true
    }
    
    public func deleteProject(project: ProjectModel) {
        projects.removeAll { model in
            model.path == project.path
        }
        let projectDB = ProjectDataBaseManager.shared
        projectDB.deleteProject(with: project.path)
    }
    
    public func update(project: ProjectModel, remark: String?) {
        guard project.remark != remark else {
            return
        }
        project.remark = remark
        let projectDB = ProjectDataBaseManager.shared
        projectDB.updateProject(new: project)
    }
    
    public func project(at index: Int) -> ProjectModel? {
        if index >= projectsCount || index < 0 {
            return nil
        }
        return projects[index]
    }
    
    public func setProjectSelected(at index: Int) {
        selectedProject = project(at: index)
    }
}
