//
//  ProjectsListView.swift
//  getp
//
//  Created by niren on 2023/4/4.
//

import Cocoa

class ProjectsListView: NSView {

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
                print("receive---\(url.path)")
            }
        } else {
            
        }
        return true
    }
}
