//
//  VersionEditWindowController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/12.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class VersionEditWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        // 无边界
//        window?.styleMask = .borderless
//        window?.titlebarAppearsTransparent = true


    }
}


extension VersionEditWindowController {

}
//(2)子类化NSWindow的view,重载drawRect，其中的圆角半径和背景颜色 自己可以调整
//
//- (void)drawRect:(NSRect)dirtyRect {
//
//    [NSGraphicsContext saveGraphicsState];
//
//    NSRect rect = [self bounds];
//
//    NSBezierPath *path = [NSBezierPath bezierPathWithRoundedRect:rect xRadius:5 yRadius:5];
//
//    [path addClip];
//
//    [[NSColor controlColor] set];
//
//    NSRectFill(dirtyRect);
//
//    [NSGraphicsContext restoreGraphicsState];
//
//    [super drawRect:dirtyRect];
//
//}
