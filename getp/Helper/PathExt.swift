//
//  StringExt.swift
//  getp
//
//  Created by niren on 2023/4/6.
//

import Foundation

extension String {
    
    /// 获取路径的最后一段名字
    public var baseName: String {
        let fileManager = FileManager.default
        return fileManager.displayName(atPath: self)
    }
    
    /// 获取路径的扩展名
    public var extName: String {
        guard !baseName.isEmpty else {
            return ""
        }
        guard baseName.contains(".") else {
            return ""
        }
        return baseName.components(separatedBy: ["."]).last ?? ""
    }
    
    /// 路径是否存在
    public var pathExists: Bool {
        let fileManager = FileManager.default
        return fileManager.fileExists(atPath: self)
    }
    
    /// 判断路径是否是目录
    public var isDirectory: Bool {
        guard pathExists else {
            return false
        }
        let fileManager = FileManager.default
        if let attributes = try? fileManager.attributesOfItem(atPath: self) {
            if let type = attributes[FileAttributeKey.type] as? FileAttributeType {
                if type == .typeDirectory {
                    return true
                }
            }
        }
        return false
    }
    
    /// 返回目录下的所有文件/文件夹的路径
    public var subPaths: [String] {
        guard isDirectory else {
            return []
        }
        var paths: [String] = []
        let contents = self.subContents
        for content in contents {
            let fullpath = "\(self)/\(content)"
            paths.append(fullpath)
        }
        return paths
    }
    
    /// 返回目录下的所有文件/文件夹的名字
    public var subContents: [String] {
        guard isDirectory else {
            return []
        }
        let fileManager = FileManager.default
        if let contents = try? fileManager.contentsOfDirectory(atPath: self) {
            return contents
        }
        return []
    }
}
