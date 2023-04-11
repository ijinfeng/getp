//
//  LinkButton.swift
//  getp
//
//  Created by JinFeng on 2023/4/11.
//

import Cocoa

@IBDesignable class LinkButton: CursorEnableButton {

    @IBInspectable var tip: String! {
        didSet {
            toolTip = tip
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        attributedTitle = NSAttributedString(string: title, attributes: [
                                                                         .foregroundColor: NSColor.text6
            
        ])
    }
    
    override func mouseEntered(with event: NSEvent) {
        super.mouseEntered(with: event)
        
        attributedTitle = NSAttributedString(string: title, attributes:
                                                [
                                                    .underlineStyle: NSUnderlineStyle.single.rawValue,
                                                    .underlineColor: NSColor.text3,
                                                    .foregroundColor: NSColor.text3
                                                ])
    }
    
    override func mouseExited(with event: NSEvent) {
        super.mouseExited(with: event)
        attributedTitle = NSAttributedString(string: title, attributes: [
                                                                         .foregroundColor: NSColor.text6
            
        ])
    }
}
