//
//  ProjectsActionBarViewController.swift
//  getp
//
//  Created by niren on 2023/4/4.
//

import Cocoa

class ProjectsActionBarViewController: NSViewController {

    public var dragSuccessCallback: ((_ paths: [String]) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func onClickAddProject(_ sender: NSButton) {
        let panel = NSOpenPanel()
        panel.message = "请选择需要被管理的项目"
        panel.allowsMultipleSelection = true
        panel.allowsToolTipsWhenApplicationIsInactive = true
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        
        panel.directoryURL = URL(string: "\(NSHomeDirectory())/Developer")
        panel.begin { response in
            if response == NSApplication.ModalResponse.OK {
                for url in panel.urls {
                    let path = url.relativePath
                    GetpManager.shared.projectHanlder.addProject(path: path)
                    if let callback = self.dragSuccessCallback {
                        callback([path])
                    }
                }
            }
        }
    }
}
