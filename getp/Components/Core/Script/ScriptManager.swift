//
//  ScriptManager.swift
//  getp
//
//  Created by niren on 2023/4/7.
//

// App Sandbox Temporary Exception Entitlements
// https://developer.apple.com/library/archive/documentation/Miscellaneous/Reference/EntitlementKeyReference/Chapters/AppSandboxTemporaryExceptionEntitlements.html

import Foundation

public class ScriptManager {
    public static let shared = ScriptManager()
    
    private init() {}
    
    public let commandFactory = ScriptFactory()
    
    public static let commandFactory = ScriptManager.shared.commandFactory
}




protocol AppleScript {
    func excute(_ source: String) throws
}

extension AppleScript {
    func excute(_ source: String) throws {
        guard let script = NSAppleScript(source: source) else {
            throw GetpError.cannotCreateAppleScript(source)
        }
        var error: NSDictionary?
        script.executeAndReturnError(&error)
        if error != nil {
            throw GetpError.cannotExcuteAppleScript(source, error: error?.description)
        }
    }
}


extension ScriptManager: AppleScript {}
