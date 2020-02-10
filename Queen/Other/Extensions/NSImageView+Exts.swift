//
//  NSImageView+Exts.swift
//  Queen
//
//  Created by 聂子 on 2020/2/9.
//  Copyright © 2020 聂子. All rights reserved.
//

import Cocoa

extension NSImageView {
    private struct AssociatedKey {
        static var UserInteractionEnabledKey = "UserInteractionEnabled_Key"
    }
    var isUserInteractionEnabled: Bool {
        get {
            return (objc_getAssociatedObject(self, &AssociatedKey.UserInteractionEnabledKey) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKey.UserInteractionEnabledKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
        }
    }
}


extension NSImageView {
    open override func mouseDown(with event: NSEvent) {
        if isUserInteractionEnabled, let ac = action,let tar = target {
            NSApp.sendAction(ac, to: tar, from: self)
        }
    }
}
