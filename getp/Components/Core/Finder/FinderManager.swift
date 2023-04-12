//
//  FinderManager.swift
//  getp
//
//  Created by niren on 2023/4/10.
//

import Foundation

public class FinderManager {
    public static let shared = FinderManager()
    
    private init() {}
    
    public func getDesktopPath() -> String? {
        let homePath = NSHomeDirectory()
        guard let homeUrl = URL(string: homePath) else { return nil }
        let desktopPath = homeUrl.appendingPathComponent("Desktop").path
        return desktopPath
    }
    
    public func getLoginUserPath() -> String {
        NSHomeDirectory()
    }
    
    public func open(at path: String? = ".") throws {
        var openCommand = ScriptManager.commandFactory.getOpenCommand()
        if let path = path {
            openCommand += " " + path.specialCharEscaped(2)
        }
        let source = ScriptManager.commandFactory.getDoShellScript(openCommand)
        try ScriptManager.shared.excute(source)
    }
}
