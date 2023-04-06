//
//  ViewController.swift
//  getp
//
//  Created by JinFeng on 2023/4/3.
//

import Cocoa

class MainViewController: NSViewController {

    @IBOutlet weak var toolBar: NSView!

    
    @IBOutlet weak var contentBox: NSBox!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        // 工具栏
        let toolBarViewController = ToolBarViewController(nibName: "ToolBarViewController", bundle: nil)
        let toolBarView = toolBarViewController.view
        addChild(toolBarViewController)
        toolBar.addSubview(toolBarView)
        toolBarView.translatesAutoresizingMaskIntoConstraints = false
        toolBarView.topAnchor.constraint(equalTo: toolBar.topAnchor).isActive = true
        toolBarView.leftAnchor.constraint(equalTo: toolBar.leftAnchor).isActive = true
        toolBarView.rightAnchor.constraint(equalTo: toolBar.rightAnchor).isActive = true
        toolBarView.bottomAnchor.constraint(equalTo: toolBar.bottomAnchor).isActive = true
        
        setProjectsCase()
        
    }
    
    func setProjectsCase() {
        let projectsViewController = ProjectsViewController(nibName: "ProjectsViewController", bundle: nil)
        addChild(projectsViewController)
        contentBox.contentView = projectsViewController.view
        projectsViewController.view.setEdgeConstraints(equal: contentBox)
    }
}

