//
//  ProjectsDetailHeaderViewController.swift
//  getp
//
//  Created by niren on 2023/4/6.
//

import Cocoa

class ProjectsDetailHeaderViewController: NSViewController {
    
    @IBOutlet weak var nameLabel: NSTextField!
    
    @IBOutlet weak var remarkLabel: NSTextField!
    
    @IBOutlet weak var pathLabel: NSTextField!
    
    @IBOutlet weak var ptypeLabel: NSTextField!
    
    public var model: ProjectModel? {
        didSet {
            if let model = model {
                nameLabel.stringValue = model.name
                remarkLabel.stringValue = model.remark ?? ""
                pathLabel.stringValue = model.path
                if model.ptype == .apple {
                    ptypeLabel.stringValue = "apple"
                } else if model.ptype == .flutter {
                    ptypeLabel.stringValue = "flutter"
                } else {
                    if model.ftype == .directory {
                        ptypeLabel.stringValue = "目录"
                    } else if model.ftype == .file {
                        ptypeLabel.stringValue = "文件"
                    } else {
                        ptypeLabel.stringValue = "未知"
                    }
                }
            } 
        }
    }
    
    override func awakeFromNib() {
        pathLabel.lineBreakMode = .byTruncatingTail
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func onClickCopyPath(_ sender: NSButton) {
        self.showTip(tip: "路径已复制")
    }
}
