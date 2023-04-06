//
//  TipViewController.swift
//  getp
//
//  Created by JinFeng on 2023/4/6.
//

import Cocoa

class TipViewController: NSViewController {

    @IBOutlet weak var textLabel: NSTextField!
    
    public var text: String? {
        didSet {
            if let text = text {
                textLabel.stringValue = text
            }
        }
    }
    
    override func awakeFromNib() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.white.cgColor
        view.layer?.cornerRadius = 6
        view.layer?.masksToBounds = true
        
        let shadow = NSShadow()
        shadow.shadowColor = NSColor.text3.withAlphaComponent(0.8)
        shadow.shadowOffset = NSMakeSize(0, 0)
        shadow.shadowBlurRadius = 2
        view.shadow = shadow
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}


extension NSViewController {
    
    /// 显示一个提示
    /// - Parameters:
    ///   - tip: 提示文本框
    ///   - dismissAfter: 在指定时间后消失
    func showTip(tip: String, dismissAfter: TimeInterval = 2.0) {
        dismissTipIfNeeded()
        if let window = self.view.window {
            if let rootViewController = window.contentViewController {
                let tipViewController = TipViewController(nibName: "TipViewController", bundle: nil)
                rootViewController.addChild(tipViewController)
                rootViewController.view.addSubview(tipViewController.view)
                let topC = tipViewController.view.topAnchor.constraint(equalTo: rootViewController.view.topAnchor, constant: -20)
                topC.isActive = true
                tipViewController.view.translatesAutoresizingMaskIntoConstraints = false
                tipViewController.view.centerXAnchor.constraint(equalTo: rootViewController.view.centerXAnchor).isActive = true
                tipViewController.view.widthAnchor.constraint(greaterThanOrEqualToConstant: 120).isActive = true
                tipViewController.text = tip
                rootViewController.view.layoutSubtreeIfNeeded()
                let animaDuration = 0.3
                NSAnimationContext.runAnimationGroup { context in
                    context.duration = animaDuration
                    context.allowsImplicitAnimation = true
                    
                    topC.constant = 10
                    rootViewController.view.layoutSubtreeIfNeeded()
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter + animaDuration, execute: {
                    tipViewController.removeFromParent()
                    tipViewController.view.removeFromSuperview()
                })
            }
        }
    }
    
    func dismissTipIfNeeded() {
        if let window = self.view.window {
            if let rootViewController = window.contentViewController {
                if let tipViewController = rootViewController.children.first(where: { vc in
                    return vc.isKind(of: TipViewController.self)
                }) {
                    tipViewController.removeFromParent()
                    tipViewController.view.removeFromSuperview()
                }
            }
        }
    }
}
