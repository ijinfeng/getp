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
}
