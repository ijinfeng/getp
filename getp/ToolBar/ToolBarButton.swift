//
//  ToolBarButton.swift
//  getp
//
//  Created by niren on 2023/4/4.
//

import Cocoa

@IBDesignable class ToolBarButton: NSControl {
    
    @IBInspectable var image: NSImage! {
        didSet {
            imageView.image = image
        }
    }
    
    
    @IBInspectable var tip: String! {
        didSet {
            toolTip = tip
        }
    }
    
    private let imageView: NSImageView = NSImageView()
    
    var selected: Bool = false {
        didSet {
            if selected {
                layer?.backgroundColor = NSColor.middleGray.cgColor
            } else {
                layer?.backgroundColor = NSColor.background.cgColor
            }
        }
    }
    
    override func awakeFromNib() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        wantsLayer = true
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        addTrackingArea(NSTrackingArea(rect: dirtyRect, options: [.mouseEnteredAndExited, .activeAlways], owner: self))
    }
    
    override func mouseEntered(with event: NSEvent) {
        if selected {
            return
        }
        layer?.backgroundColor = NSColor.middleGray.withAlphaComponent(0.8).cgColor
    }
    
    override func mouseExited(with event: NSEvent) {
        if selected {
            return
        }
        layer?.backgroundColor = NSColor.background.cgColor
    }
    
    override func mouseUp(with event: NSEvent) {
        if let _target = target, let _action = action {
            NSApp.sendAction(_action, to: _target, from: self)
        }
    }
}
