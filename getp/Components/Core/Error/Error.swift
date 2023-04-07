//
//  Error.swift
//  getp
//
//  Created by niren on 2023/4/7.
//

import Foundation

enum GetpError: Error {
    case cannotOpenApp(_ appName: String)
    case cannotCreateAppleScript(_ source: String)
    case cannotExcuteAppleScript(_ source: String, error: String?)
}

extension GetpError: CustomStringConvertible {
    var description: String {
        switch self {
        case .cannotOpenApp(let appName):
            return "Can not open \(appName), please check permissions."
        case .cannotCreateAppleScript(let source):
            return "Cannot create AppleScript:\n\(source)"
        case .cannotExcuteAppleScript(let error):
            return "Cannot excute AppleScript:\n\(error)"
        }
    }
}
