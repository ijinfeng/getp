//
//  ProjectsViewController.swift
//  getp
//
//  Created by niren on 2023/4/4.
//

import Cocoa

class ProjectsViewController: NSViewController {
    
    @IBOutlet weak var splitView: NSView!
    
    private let splitViewController = NSSplitViewController()
    var listViewController: ProjectsListViewController!
    var detailViewController: ProjectDetailViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    override func awakeFromNib() {
        setupUI()
    }
 
    func setupUI() {
        splitViewController.splitView.dividerStyle = .thin
        addChild(splitViewController)
        splitView.addSubview(splitViewController.view)
        splitViewController.view.setEdgeConstraints(equal: splitView)
        
        // left split view
        let leftViewController = ProjectsListViewController(nibName: "ProjectsListViewController", bundle: nil)
        listViewController = leftViewController
        let leftView = leftViewController.view
        leftView.translatesAutoresizingMaskIntoConstraints = false
        leftView.widthAnchor.constraint(lessThanOrEqualToConstant: 300).isActive = true
        leftView.widthAnchor.constraint(greaterThanOrEqualToConstant: 120).isActive = true
        let left = NSSplitViewItem(viewController: leftViewController)
        splitViewController.addSplitViewItem(left)
        
        // right split view
        let rightViewController = ProjectDetailViewController(nibName: "ProjectDetailViewController", bundle: nil)
        detailViewController = rightViewController
        let rightView = rightViewController.view
        rightView.setEdgeConstraints(equal: splitViewController.view)
        let right = NSSplitViewItem(viewController: rightViewController)
        splitViewController.addSplitViewItem(right)
    }
}


extension NSViewController {
    /// 寻找项目控制器
    func findProjectsViewController() -> ProjectsViewController? {
        if self.isKind(of: ProjectsViewController.self) {
            return self as? ProjectsViewController
        }
        var vc = self.parent
        while vc != nil {
            if ((vc?.isKind(of: NSSplitViewController.self)) != nil) {
                if ((vc?.parent?.isKind(of: ProjectsViewController.self)) != nil) {
                    return vc?.parent as? ProjectsViewController
                }
            }
            vc = vc?.parent
        }
        return nil
    }
}
