//
//  ScriptFactory.swift
//  getp
//
//  Created by niren on 2023/4/7.
//

import Foundation

public class ScriptFactory {}

public protocol TerminalCommand {
    func getOpenCommand(_ app: App, escapeCount: Int) -> String
    func getOpenCommand() -> String
}

public protocol AppleScriptCommand {
    func getDoShellScript(_ command: String) -> String
}



extension ScriptFactory: TerminalCommand {
    public func getOpenCommand(_ app: App, escapeCount: Int = 1) -> String {
        "open -a \(app.name.nameSpaceEscaped(escapeCount))"
    }
    
    public func getOpenCommand() -> String {
        "open"
    }
}

extension ScriptFactory: AppleScriptCommand {
    public func getDoShellScript(_ command: String) -> String {
       let result = """
do shell script "\(command)"
"""
        return result
    }
}



extension String {
    /// Handle space in name.
    /// `count`: number of escape characters.
    func nameSpaceEscaped(_ count: Int = 1) -> String {
        let escapeChar = String(repeating: "\\", count: count)
        let escapeSpace = escapeChar + " "
        let replaced = self.replacingOccurrences(of: " ", with: escapeSpace)
        return replaced
    }
    
    /// Handle special char in path.
    /// `count`: number of escape characters.
    func specialCharEscaped(_ count: Int = 1) -> String {
        let escapeChar = String(repeating: "\\", count: count)
        var result = ""
        let set: [Character] = [" ", "(", ")", "&", "|", ";",
                                "\"", "'", "<", ">", "`"]
        for char in self {
            if set.contains(char) {
                result += escapeChar
            }
            result.append(char)
        }
        return result
    }
}
