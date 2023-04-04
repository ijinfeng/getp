//
//  ProjectsViewController.swift
//  getp
//
//  Created by niren on 2023/4/4.
//

import Cocoa

class ProjectsViewController: NSViewController {
    
    @IBOutlet weak var splitView: NSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        setupUI()
        
    }
 
    func setupUI() {
        let splitViewController = NSSplitViewController()
        splitViewController.splitView.dividerStyle = .thin
        addChild(splitViewController)
        splitView.addSubview(splitViewController.view)
        splitViewController.view.setEdgeConstraints(equal: splitView)
        
        // left split view
        let leftViewController = ProjectsListViewController(nibName: "ProjectsListViewController", bundle: nil)
        let leftView = leftViewController.view
        splitViewController.addChild(leftViewController)
        leftView.translatesAutoresizingMaskIntoConstraints = false
        leftView.widthAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
        leftView.widthAnchor.constraint(greaterThanOrEqualToConstant: 120).isActive = true
        
        // right split view
        let rightViewController = ProjectDetailViewController(nibName: "ProjectDetailViewController", bundle: nil)
        let rightView = rightViewController.view
        splitViewController.addChild(rightViewController)
        rightView.setEdgeConstraints(equal: splitViewController.view)
        
        let left = NSSplitViewItem(viewController: leftViewController)
        let right = NSSplitViewItem(viewController: rightViewController)
        splitViewController.addSplitViewItem(left)
        splitViewController.addSplitViewItem(right)
        
    }
    
}
