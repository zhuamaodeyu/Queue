//
//  TerminalTextView.swift
//  Queen
//
//  Created by 聂子 on 2019/9/14.
//  Copyright © 2019 聂子. All rights reserved.
//

import AppKit

//extension NSTextView {
//    private struct AssociatedKey {
//        static var attributeText = "NSTextView_attributeText"
//    }
//
//    var hasText: Bool {
//        return self.attributeText?.length ?? 0 > 0
//    }
//
//    var attributeText: NSMutableAttributedString? {
//        get {
//            return objc_getAssociatedObject(self, AssociatedKey.attributeText) as?  NSMutableAttributedString ?? NSMutableAttributedString.init()
//        }
//        set {
//            objc_setAssociatedObject(self, AssociatedKey.attributeText, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            guard let attributedText = newValue else {
//                return
//            }
//            // scroll to buttom
//            let scrolledToBottom = NSMaxY(self.visibleRect) != NSMaxY(self.bounds)
//            self.textStorage?.setAttributedString(attributedText)
//            if (scrolledToBottom) {
//                self.scrollToEndOfDocument(self)
//            } else {
//                self.scroll(self.visibleRect.origin)
//            }
//        }
//    }
//
//}

extension NSTextView {
    func scrollBottom() {

//        self.enclosingScrollView?.lineScroll = 0.0
//        self.enclosingScrollView?.pageScroll = 0.0
//
//        var scrollLocation = self.enclosingScrollView?.contentView.bounds.origin.y ?? 0.0 + 10.0
//        let  maxScroll = (self.enclosingScrollView?.documentView?.bounds.size.height ?? 0.0) - (self.enclosingScrollView?.documentVisibleRect.size.height ?? 0.0)
//
//        scrollLocation += maxScroll
//
//        if scrollLocation < 0 {
//            scrollLocation = 0
//        }else if (scrollLocation > maxScroll) {
//            scrollLocation = maxScroll
//        }
//        guard let scrollView = self.enclosingScrollView else {
//            return
//        }
//
//        scrollView.contentView.scroll(NSPoint.init(x: 0, y: scrollLocation))
//        scrollView.reflectScrolledClipView(scrollView.contentView)

        let scrolledToBottom = NSMaxY(self.visibleRect) != NSMaxY(self.bounds)
        if (scrolledToBottom) {
            self.scrollToEndOfDocument(self)
        } else {
            self.scroll(self.visibleRect.origin)
        }

    }
}
