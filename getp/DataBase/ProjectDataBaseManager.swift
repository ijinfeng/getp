//
//  ProjectDataBaseManager.swift
//  getp
//
//  Created by niren on 2023/4/14.
//

// https://juejin.cn/post/7011708888718245925

import Foundation
import CoreData

class ProjectDataBaseManager {
    static let shared = ProjectDataBaseManager()
    private init() {
        createDataBase()
    }
    
    private var persistentContainer: NSPersistentContainer?
    private var loaded: Bool = false
    
    func createDataBase() {
        persistentContainer = NSPersistentContainer(name: "project")
    }
    
    func load(completionHandler block: ((URL) -> Void)? = nil) {
        guard let persistentContainer = persistentContainer else {
            return
        }
        persistentContainer.loadPersistentStores { [weak self] desc, error in
            if let error = error {
                fatalError("Load persistent stores error: \(error)")
            }
            self?.loaded = true
            let url = NSPersistentContainer.defaultDirectoryURL()
            print("Successfuly load persistent stores => \(url.absoluteString)")
            block?(url)
        }
    }
    
    func readProjects() -> [ProjectModel] {
        guard loaded else {
            return []
        }
        if let persistentContainer = persistentContainer {
            let context = persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<ProjectMO>(entityName: "Project")
            do {
                let projects = try context.fetch(fetchRequest)
                print("Successfuly find \(projects.count) projects")
                return projects.map { mo in
                    let project = ProjectModel(mo: mo)
                    return project
                }
            } catch {
                print("Faild read projects: \(error)")
            }
        }
        return []
    }
    
    func insertNewProject(project: ProjectModel) {
        guard loaded else {
            return
        }
        if let persistentContainer = persistentContainer {
            let context = persistentContainer.viewContext
            let projectMO = NSEntityDescription.insertNewObject(forEntityName: "Project", into: context) as! ProjectMO
            projectMO.name = project.name
            projectMO.path = project.path
            projectMO.remark = project.remark
            projectMO.ptype = Int16(project.ptype.rawValue)
            projectMO.ftype = Int16(project.ftype.rawValue)
            if context.hasChanges {
                do {
                    try context.save()
                    print("Successfuly insert new project: \(project)")
                } catch {
                    print("Insert project error: \(error)")
                }
            }
        }
    }
    
    func deleteProject(with path: String) {
        guard loaded else {
            return
        }
        if let persistentContainer = persistentContainer {
            let context = persistentContainer.viewContext
            let request = NSFetchRequest<ProjectMO>(entityName: "Project")
            request.predicate = NSPredicate(format: "path = \"\(path)\"")
            do {
                let deleteProject = try context.fetch(request)
                deleteProject.forEach { mo in
                    context.delete(mo)
                }
                if context.hasChanges {
                    try context.save()
                }
                print("Successfuly delete project with path: \(path)")
            } catch {
                print("Failed to delete project with path: \(path)")
            }
        }
    }
    
    func updateProject(new project: ProjectModel) {
        guard loaded else {
            return
        }
        if let persistentContainer = persistentContainer {
            let context = persistentContainer.viewContext
            let request = NSFetchRequest<ProjectMO>(entityName: "Project")
            request.predicate = NSPredicate(format: "path = \"\(project.path)\"")
            do {
                if let updateProject = try context.fetch(request).first {
                    updateProject.name = project.name
                    updateProject.path = project.path
                    updateProject.remark = project.remark
                    updateProject.ptype = Int16(project.ptype.rawValue)
                    updateProject.ftype = Int16(project.ftype.rawValue)
                    if context.hasChanges {
                        try context.save()
                    }
                    print("Successfuly update project: \(project)")
                }
            } catch {
                print("Failed to delete project: \(project)")
            }
        }
    }
}
