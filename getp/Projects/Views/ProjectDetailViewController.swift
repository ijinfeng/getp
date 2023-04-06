//
//  ProjectDetailViewController.swift
//  getp
//
//  Created by niren on 2023/4/4.
//

import Cocoa

class ProjectDetailViewController: NSViewController {

    @IBOutlet weak var coverView: NSView!
    
    
    @IBOutlet weak var headerView: NSView!
    
    private let headerViewController = ProjectsDetailHeaderViewController(nibName: "ProjectsDetailHeaderViewController", bundle: nil)
    
    
    public var model: ProjectModel? {
        didSet {
            if let model = model {
                headerViewController.model = model
                coverView.isHidden = true
                headerView.isHidden = false
            } else {
                coverView.isHidden = false
                headerView.isHidden = true
            }
        }
    }
    
    override func awakeFromNib() {
        coverView.wantsLayer = true
        coverView.layer?.backgroundColor = NSColor.background.cgColor
        addChild(headerViewController)
        headerView.addSubview(headerViewController.view)
        headerViewController.view.setEdgeConstraints(equal: headerView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
}
