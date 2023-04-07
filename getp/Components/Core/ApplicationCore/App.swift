//
//  App.swift
//  getp
//
//  Created by niren on 2023/4/7.
//

import Foundation
import ScriptingBridge

public enum AppType: String {
    case terminal
    case editor
}


public struct App {
    public var name: String
    public var path: String?
    public var bid: String
    public var type: AppType
    public var isInstalled: Bool
    
    public init(name: String, bid: String, type: AppType, path: String?) {
        self.name = name
        self.bid = bid
        self.type = type
        self.path = path
        self.isInstalled = path != nil && !path!.isEmpty
    }
}

extension App: Equatable {
    public static func ==(lhs: App, rhs: App) -> Bool {
        lhs.name == rhs.name && lhs.bid == rhs.bid
    }
}




public protocol Openable {
    func open(in path: String?) throws
}


extension App: Openable {
    public func open(in path: String? = nil) throws {
        switch self.type {
        case .terminal:
            if SupportedApps.accept(app: self, is: .terminal) {
                guard let terminal = SBApplication(bundleIdentifier: SupportedApps.terminal.bundleIdentifier) as TerminalApplication?, let open = terminal.open else {
                    throw GetpError.cannotOpenApp(self.name)
                }
                if let path = path {
                    if #available(macOS 13.0, *) {
                        open([URL(filePath: path)])
                    } else {
                        // Fallback on earlier versions
                        let url = URL(fileURLWithPath: path)
                        open([url])
                    }
                } else {
                    open([])
                }
                terminal.activate()
            } else {
                var openCommand = ScriptManager.commandFactory.getOpenCommand(self, escapeCount: 2)
                if let path = path {
                    openCommand += " " + path.specialCharEscaped(2)
                }
                let source = ScriptManager.commandFactory.getDoShellScript(openCommand)
                try ScriptManager.shared.excute(source)
            }
        case .editor:
            var openCommand = ScriptManager.commandFactory.getOpenCommand(self, escapeCount: 2)
            if let path = path {
                openCommand += " " + path.specialCharEscaped(2)
            }
            let source = ScriptManager.commandFactory.getDoShellScript(openCommand)
            try ScriptManager.shared.excute(source)
        }
    }
}
