//
//  LayoutExt.swift
//  getp
//
//  Created by niren on 2023/4/4.
//

import Foundation
import AppKit

extension NSView {
    func setEdgeConstraints(equal toView: NSView) -> Void {
        if toView.subviews.contains(self) {
            translatesAutoresizingMaskIntoConstraints = false
            topAnchor.constraint(equalTo: toView.topAnchor).isActive = true
            leftAnchor.constraint(equalTo: toView.leftAnchor).isActive = true
            rightAnchor.constraint(equalTo: toView.rightAnchor).isActive = true
            bottomAnchor.constraint(equalTo: toView.bottomAnchor).isActive = true
        }
    }
}
