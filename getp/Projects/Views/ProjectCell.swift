//
//  ProjectCell.swift
//  getp
//
//  Created by niren on 2023/4/4.
//

import Cocoa

class ProjectCell: NSTableCellView {
    
    @IBOutlet weak var iconImageView: NSImageView!
    
    @IBOutlet weak var nameLabel: NSTextField!
    
    @IBOutlet weak var remarkLabel: NSTextField!
    
    @IBOutlet weak var pathLabel: NSTextField!
    
    
    public var model: ProjectModel? {
        didSet {
            if let model = model {
                nameLabel.stringValue = model.name
                remarkLabel.stringValue = model.remark ?? ""
                pathLabel.stringValue = model.path
                
                if model.ptype == .apple {
                    iconImageView.image = NSImage(named: "icon_proj_apple")
                } else if model.ptype == .flutter {
                    iconImageView.image = NSImage(named: "icon_proj_flutter")
                } else {
                    if model.ftype == .directory {
                        iconImageView.image = NSImage(named: "icon_proj_dir")
                    } else if model.ftype == .file {
                        iconImageView.image = NSImage(named: "icon_proj_file")
                    } else {
                        iconImageView.image = NSImage(named: "icon_proj_unknown")
                    }
                }
            }
        }
    }
}
