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
    
    private var currentViewController: NSViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        // 工具栏
        let toolBarViewController = ToolBarViewController(nibName: "ToolBarViewController", bundle: nil)
        toolBarViewController.delegate = self
        let toolBarView = toolBarViewController.view
        addChild(toolBarViewController)
        toolBar.addSubview(toolBarView)
        toolBarView.translatesAutoresizingMaskIntoConstraints = false
        toolBarView.topAnchor.constraint(equalTo: toolBar.topAnchor).isActive = true
        toolBarView.leftAnchor.constraint(equalTo: toolBar.leftAnchor).isActive = true
        toolBarView.rightAnchor.constraint(equalTo: toolBar.rightAnchor).isActive = true
        toolBarView.bottomAnchor.constraint(equalTo: toolBar.bottomAnchor).isActive = true
    }
    
    func setProjectsCase() {
        let projectsViewController = ProjectsViewController(nibName: "ProjectsViewController", bundle: nil)
        addChild(projectsViewController)
        contentBox.contentView = projectsViewController.view
        projectsViewController.view.setEdgeConstraints(equal: contentBox)
        
        currentViewController = projectsViewController
    }
    
    func setConvenienceCase() {
        let convenienceViewController = ConvenienceViewController(nibName: "ConvenienceViewController", bundle: nil)
        addChild(convenienceViewController)
        contentBox.contentView = convenienceViewController.view
        convenienceViewController.view.setEdgeConstraints(equal: contentBox)
        
        currentViewController = convenienceViewController
    }
    
    func setToyBricksCase() {
        let toyBricksViewController = ToyBricksViewController(nibName: "ToyBricksViewController", bundle: nil)
        addChild(toyBricksViewController)
        contentBox.contentView = toyBricksViewController.view
        toyBricksViewController.view.setEdgeConstraints(equal: contentBox)
        
        currentViewController = toyBricksViewController
    }
}

extension MainViewController: ToolBarDelegate {
    func didSelectedPcase(pcase: GetpCase) {
        if let currentViewController = currentViewController {
            currentViewController.removeFromParent()
        }
        currentViewController = nil
        
        switch pcase {
        case .project:
            setProjectsCase()
        case .tool:
            setConvenienceCase()
        case .bricks:
            setToyBricksCase()
        }
    }
}
