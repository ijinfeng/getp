//
//  ProjectDetailViewController.swift
//  getp
//
//  Created by niren on 2023/4/4.
//

import Cocoa

class ProjectDetailViewController: NSViewController {

    @IBOutlet weak var coverView: NSView!
    
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
                coverView.isHidden = true
            } else {
                coverView.isHidden = false
            }
        }
    }
    
    override func awakeFromNib() {
        coverView.wantsLayer = true
        coverView.layer?.backgroundColor = NSColor.background.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        
    }
}
