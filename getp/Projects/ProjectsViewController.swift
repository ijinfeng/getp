//
//  ProjectsViewController.swift
//  getp
//
//  Created by niren on 2023/4/4.
//

import Cocoa

/// 项目管理
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
        splitViewController.splitView.isVertical = true
        addChild(splitViewController)
        splitView.addSubview(splitViewController.view)
        splitViewController.view.setEdgeConstraints(equal: splitView)
        
        // left split view
        let leftViewController = ProjectsListViewController(nibName: "ProjectsListViewController", bundle: nil)
        let leftView = leftViewController.view
        let left = NSSplitViewItem(viewController: leftViewController)
        left.minimumThickness = 120
        left.maximumThickness = 300
        splitViewController.addSplitViewItem(left)
        
        // right split view
        let rightViewController = ProjectDetailViewController(nibName: "ProjectDetailViewController", bundle: nil)
        detailViewController = rightViewController
        let rightView = rightViewController.view
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
