//
//  ToolBarViewController.swift
//  getp
//
//  Created by niren on 2023/4/4.
//

import Cocoa

class ToolBarViewController: NSViewController {

    private var selectedButton: ToolBarButton?
    
    @IBOutlet weak var projectsButton: ToolBarButton!
    
    @IBOutlet weak var toolButton: ToolBarButton!
    
    @IBOutlet weak var textLabel: NSTextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textLabel.textColor = NSColor.text6
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.background.cgColor
        GetpManager.shared.pcase = .project
        setButtonSelected(projectsButton)
    }
    
    func setButtonSelected(_ button: ToolBarButton) {
        selectedButton?.selected = false
        selectedButton = button
        selectedButton?.selected = true
        switch GetpManager.shared.pcase {
        case .project:
            textLabel.stringValue = "项目管理"
        case .tool:
            textLabel.stringValue = "便捷工具"
        }
    }
    
    @IBAction @objc func onClickProject(_ sender: ToolBarButton) {
        GetpManager.shared.pcase = .project
        setButtonSelected(sender)
        
    }
    
    @IBAction  @objc func onClickTool(_ sender: ToolBarButton) {
        GetpManager.shared.pcase = .tool
        setButtonSelected(sender)
    }

}
