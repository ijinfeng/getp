//
//  ToolBarViewController.swift
//  getp
//
//  Created by niren on 2023/4/4.
//

import Cocoa

protocol ToolBarDelegate: NSObjectProtocol {
    func didSelectedPcase(pcase: GetpCase)
}

class ToolBarViewController: NSViewController {

    private var selectedButton: ToolBarButton?
    
    public weak var delegate: ToolBarDelegate?
    
    @IBOutlet weak var projectsButton: ToolBarButton!
    
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
        
        if let delegate = delegate {
            delegate.didSelectedPcase(pcase: GetpManager.shared.pcase)
        }
        
        switch GetpManager.shared.pcase {
        case .project:
            textLabel.stringValue = "项目管理"
        case .tool:
            textLabel.stringValue = "便捷工具"
        case .bricks:
            textLabel.stringValue = "积木"
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

    @IBAction func onClickToyBricks(_ sender: ToolBarButton) {
        GetpManager.shared.pcase = .bricks
        setButtonSelected(sender)
    }
    
    
    @IBAction func onClickSetting(_ sender: Any) {
        let test = TestViewController(nibName: "TestViewController", bundle: nil)
        let window = NSWindow(contentViewController: test)
        window.title = "测试"
        window.center()
        window.orderFront(nil)
    }
}
