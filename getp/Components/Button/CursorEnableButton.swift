//
//  CursorEnableButton.swift
//  getp
//
//  Created by JinFeng on 2023/4/11.
//

// https://www.jianshu.com/p/2fba9ef3325e

import Cocoa

class CursorEnableButton: NSButton {

    private var trackingArea: NSTrackingArea?
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        // Drawing code here.
    }
    
    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        if trackingArea == nil {
            let superIsTextView = superview is NSTextView
            if superIsTextView {
                trackingArea = NSTrackingArea(rect: self.bounds,options: [.mouseMoved,.activeAlways], owner: self)
            } else {
                trackingArea = NSTrackingArea(rect: self.bounds,options: [.mouseEnteredAndExited, .activeAlways], owner: self)
            }
            addTrackingArea(trackingArea!)
        }
    }
    
    override func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
        DispatchQueue.main.async {
            NSCursor.pointingHand.set()
        }
    }
    
    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        DispatchQueue.main.async {
            NSCursor.pointingHand.set()
        }
    }
    
    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        DispatchQueue.main.async {
            NSCursor.arrow.set()
        }
    }
    
    override func removeFromSuperview() {
            if trackingArea != nil {
                removeTrackingArea(trackingArea!)
            }
            super.removeFromSuperview()
        }
}
