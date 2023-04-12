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
    
    @IBOutlet weak var pathLabelButton: NSButton!
    
    @IBOutlet weak var ptypeLabel: NSTextField!
    
    @IBOutlet weak var popupButton: NSPopUpButton!
    
    private var terminals: [SupportedApps] = []
    private var editors: [SupportedApps] = []
    
    private var invaildPopup = false;
    
    public var model: ProjectModel? {
        didSet {
            if let model = model {
                nameLabel.stringValue = model.name
                remarkLabel.stringValue = model.remark ?? ""
                pathLabelButton.title = model.path
                
                var items: [String] = []
                if model.ptype == .apple {
                    ptypeLabel.stringValue = "apple"
                    if editors.contains(.xcode) {
                        items.append(SupportedApps.xcode.name)
                    }
                } else if model.ptype == .flutter {
                    ptypeLabel.stringValue = "flutter"
                    if editors.contains(.androidStudio) {
                        items.append(SupportedApps.androidStudio.name)
                    }
                } else {
                    if model.ftype == .directory {
                        ptypeLabel.stringValue = "目录"
                    } else if model.ftype == .file {
                        ptypeLabel.stringValue = "文件"
                    } else {
                        ptypeLabel.stringValue = "未知"
                    }
                }
                if terminals.contains(.iTerm2) {
                    items.append(SupportedApps.iTerm2.name)
                } else if terminals.contains(.terminal) {
                    items.append(SupportedApps.terminal.name)
                }
                if editors.contains(.vscode) {
                    items.append(SupportedApps.vscode.name)
                }
                if (items.isEmpty) {
                    if editors.contains(.textedit) {
                        items.append(SupportedApps.textedit.name)
                    }
                    if items.isEmpty {
                        items.append("没有任何可用IDE")
                        invaildPopup = true
                    }
                }
                popupButton.addItems(withTitles: items)
                popupButton.selectItem(at: 0)
            } 
        }
    }
    
    override func awakeFromNib() {
        popupButton.removeAllItems()
        let _terminals = SupportedApps.terminals.filter { app in
            return app.installed
        }
        terminals.append(contentsOf: _terminals)
        
        let _editors = SupportedApps.editors.filter({ $0.installed })
        editors.append(contentsOf: _editors)
        
        invaildPopup = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func onClickCopyPath(_ sender: NSButton) {
        if let path = model?.path {
            self.showTip(tip: "路径已拷贝")
            let pasteboard = NSPasteboard.general;
            pasteboard.clearContents()
            pasteboard.setString(path, forType: .string)
        }
    }
    
    
    @IBAction func onClickFinder(_ sender: NSButton) {
        let finder = FinderManager.shared
        try? finder.open(at: model?.path ?? finder.getLoginUserPath())
    }
    
    @IBAction func onClickProject(_ sender: NSButton) {
        guard !invaildPopup else {
            return
        }
        if let item = popupButton.selectedItem {
            let name = item.title
            try? SupportedApps.createApp(with: name)?.open(in: model?.path)
        }
    }
}
