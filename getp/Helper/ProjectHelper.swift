//
//  ProjectHelper.swift
//  getp
//
//  Created by niren on 2023/4/4.
//

import Foundation
import AppKit

/// 主题色
let kThemeColor: NSColor = NSColor.hexColor(hex: 0xE5E6EA)

extension NSColor {
    
    /// 十六进制颜色
    /// - Parameter hex: 整型0xFFFFFF
    /// - Returns: NSColor
    class func hexColor(hex: Int) -> NSColor {
        let r = CGFloat(((hex & 0xFF0000) >> 16)) / 255.0
        let g = CGFloat(((hex & 0xFF00) >> 8)) / 255.0
        let b = CGFloat((hex & 0xFF)) / 255.0
        return NSColor(red: (r), green: (g), blue: (b), alpha: 1.0)
    }
    
    /// 十六进制颜色
    /// - Parameter hex: 字符串0xFFFFFF
    /// - Returns: NSColor
    class func hexColor(hex: String) -> NSColor {
        var _hex: Substring = Substring(stringLiteral: hex)
        let length = hex.count
        if (hex.starts(with: "#")) {
            _hex = hex.suffix(length - 1)
        }
        if (hex.starts(with: "0x")) {
            _hex = hex.suffix(length - 2)
        }
        return hexColor(hex: Int(String(_hex).prefix(6), radix: 16) ?? 0xFFFFFF)
    }
    
    /// 淡灰色
    class var thinGray: NSColor {
        return hexColor(hex: 0xF9F9F9)
    }
    
    /// 中度灰色
    class var middleGray: NSColor {
        return hexColor(hex: 0xF5F5F5)
    }
    
    class var text3: NSColor {
        return hexColor(hex: 0x333333)
    }
    
    class var text6: NSColor {
        return hexColor(hex: 0x666666)
    }
    
    class var text9: NSColor {
        return hexColor(hex: 0x999999)
    }
    
    /// 黑色 0x333333
    class var tblack: NSColor {
        return hexColor(hex: 0x333333)
    }
    
    /// 背景色
    class var background: NSColor {
        return hexColor(hex: 0xF4F5F6)
    }
}
