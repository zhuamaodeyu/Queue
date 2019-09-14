//
//  TerminalTextView.swift
//  Queen
//
//  Created by 聂子 on 2019/9/14.
//  Copyright © 2019 聂子. All rights reserved.
//

import AppKit

extension NSTextView {
    private struct AssociatedKey {
        static var attributeText = "NSTextView_attributeText"
    }

    var hasText: Bool {
        return self.attributeText?.length ?? 0 > 0
    }

    var attributeText: NSMutableAttributedString? {
        get {
            return objc_getAssociatedObject(self, AssociatedKey.attributeText) as?  NSMutableAttributedString
        }
        set {
            objc_setAssociatedObject(self, AssociatedKey.attributeText, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            guard let attributedText = newValue else {
                return
            }
            // scroll to buttom
            let scrolledToBottom = NSMaxY(self.visibleRect) != NSMaxY(self.bounds)
            self.textStorage?.setAttributedString(attributedText)
            if (scrolledToBottom) {
                self.scrollToEndOfDocument(self)
            } else {
                self.scroll(self.visibleRect.origin)
            }
        }
    }

}
