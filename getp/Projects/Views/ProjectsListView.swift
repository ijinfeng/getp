//
//  ProjectsListView.swift
//  getp
//
//  Created by niren on 2023/4/4.
//

import Cocoa

class ProjectsListView: NSView {

    public var dragSuccessCallback: ((_ paths: [String]) -> Void)?
    
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        registerForDraggedTypes([NSPasteboard.PasteboardType.fileURL])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        registerForDraggedTypes([NSPasteboard.PasteboardType.fileURL])
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        let mask = sender.draggingSourceOperationMask
        let board = sender.draggingPasteboard
        if ((board.types?.contains(NSPasteboard.PasteboardType.fileURL)) != nil) {
            if (mask.contains(.copy)) {
                return .copy
            }
        }
        return [.every]
    }
    
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        let board = sender.draggingPasteboard
        let itemsCount = board.pasteboardItems?.count ?? 0
        if (itemsCount <= 1) {
            let url = NSURL(from: board)
            if let url = url {
                let path = url.path ?? ""
                GetpManager.shared.projectHanlder.addProject(path: path)
                if let callback = dragSuccessCallback {
                    callback([path])
                }
            }
        } else {
            if let items = board.pasteboardItems {
                for item in items {
                    if let url = item.propertyList(forType: .fileURL) as? String {
                        if let URL = URL(string: url) {
                            let path = URL.relativePath
                            GetpManager.shared.projectHanlder.addProject(path: path)
                            if let callback = dragSuccessCallback {
                                callback([path])
                            }
                        }
                    }
                }
            }
        }
        return true
    }
}
