//
//  SupportedApps.swift
//  getp
//
//  Created by niren on 2023/4/7.
//

import Foundation
import AppKit


public enum SupportedApps: String, CaseIterable {
    
    case iTerm2 = "iTerm"
    case terminal = "Terminal"
    case xcode = "Xcode"
    case vscode = "Visual Studio Code"
    case androidStudio = "Android Studio"
    case textedit = "TextEdit"
    
    public var name: String {
        self.rawValue
    }
    
    public var shortName: String {
        switch self {
        case .iTerm2, .terminal, .xcode, .textedit:
            return self.rawValue
        case .vscode:
            return "VSCode"
        case .androidStudio:
            return "AndroidStudio"
        }
    }
    
    public var type: AppType {
        switch self {
        case .terminal, .iTerm2:
            return .terminal
        default:
            return .editor
        }
    }
    
    public static func isSupported(_ app: App) -> Bool {
        for sa in SupportedApps.allCases {
            if sa.name == app.name {
                return true
            }
        }
        return false
    }
    
    public static func isSupported(_ name: String) -> Bool {
        for sa in SupportedApps.allCases {
            if sa.name == name || sa.shortName == name {
                return true
            }
        }
        return false
    }
    
    public static func accept(app: App, is supported: SupportedApps) -> Bool {
        app.name == supported.name
    }
    
    public static var terminals: [SupportedApps] {
        return SupportedApps.allCases.filter {
            $0.type == .terminal
        }
    }
    
    public static var editors: [SupportedApps] {
        return SupportedApps.allCases.filter {
            $0.type == .editor
        }
    }
    
    public static func app(createname: String) -> App? {
        return nil
    }
    
    public var bundleIdentifier: String {
        switch self {
        case .iTerm2: return "com.googlecode.iterm2"
        case .terminal: return "com.apple.Terminal"
        case .xcode: return "com.apple.dt.Xcode"
        case .vscode: return "com.microsoft.VSCode"
        case .androidStudio: return "com.google.android.studio"
        case .textedit: return "com.apple.TextEdit"
        }
    }
    
    public var path: String? {
        NSWorkspace.shared.urlForApplication(withBundleIdentifier: self.bundleIdentifier)?.relativePath
    }
    
    
    public var app: App {
        App(name: self.name, bid: self.bundleIdentifier, type: self.type, path: self.path)
    }
}
