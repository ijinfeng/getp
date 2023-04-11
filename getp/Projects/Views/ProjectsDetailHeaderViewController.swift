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
    
    @IBOutlet weak var popupButton: NSPopUpButton!
    
    
    public var model: ProjectModel? {
        didSet {
            if let model = model {
                nameLabel.stringValue = model.name
                remarkLabel.stringValue = model.remark ?? ""
                pathLabel.stringValue = model.path
                
                var items = ["终端", "VSCode"]
                if model.ptype == .apple {
                    ptypeLabel.stringValue = "apple"
                    items.append("Xcode")
                } else if model.ptype == .flutter {
                    ptypeLabel.stringValue = "flutter"
                    items.append("Android Studio")
                } else {
                    if model.ftype == .directory {
                        ptypeLabel.stringValue = "目录"
                    } else if model.ftype == .file {
                        ptypeLabel.stringValue = "文件"
                    } else {
                        ptypeLabel.stringValue = "未知"
                    }
                }
                popupButton.addItems(withTitles: items)
                if model.ptype == .apple {
                    popupButton.selectItem(at: 2)
                } else if model.ptype == .flutter {
                    popupButton.selectItem(at: 1)
                } else {
                    popupButton.selectItem(at: 1)
                }
            } 
        }
    }
    
    override func awakeFromNib() {
        popupButton.removeAllItems()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func onClickCopyPath(_ sender: NSButton) {
        self.showTip(tip: "路径已复制")
    }
    
    
    @IBAction func onClickFinder(_ sender: NSButton) {
        
    }
    
    @IBAction func onClickProject(_ sender: NSButton) {
        if let item = popupButton.selectedItem {
            
        }
    }
}
