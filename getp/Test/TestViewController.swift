//
//  TestViewController.swift
//  getp
//
//  Created by niren on 2023/4/7.
//

import Cocoa

class TestViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        let dataBase = ProjectDataBaseManager.shared;
        dataBase.createDataBase()
        dataBase.load()
    }
    
    
    
    @IBAction func onClickExists(_ sender: NSButton) {
        let dataBase = ProjectDataBaseManager.shared;
        dataBase.readProjects()
    }
    
    
    @IBAction func onClickOpenApp(_ sender: NSButton) {
        let dataBase = ProjectDataBaseManager.shared;
        let project = ProjectModel(path: "/Users/niren/Desktop/works")
        project.remark = "我是一个备注"
        dataBase.insertNewProject(project: project)
    }
}
