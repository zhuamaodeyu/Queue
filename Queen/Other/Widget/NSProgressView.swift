//
//  NSProgressView.swift
//  Queen
//
//  Created by 聂子 on 2020/2/10.
//  Copyright © 2020 聂子. All rights reserved.
//

import Cocoa

class NSProgressView: NSView {
    var style: Style = .default
    
    private(set) var progress: Float = 0
    
    var progressTinColor: NSColor? {
        didSet {
            progressView.backgroundColor = progressTinColor
        }
    }
    
    private var progressView: NSView = NSView.init()
    
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.addSubview(progressView)
        
    }
    
    convenience init(progressViewStyle: NSProgressView.Style) {
        self.init(frame: .zero)
        self.style = progressViewStyle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        if progressView.height !=  self.height {
            progressView.frame = NSRect.init(x: 0, y: 0, width: 0, height: self.height)
        }
        if progressView.width != self.width * CGFloat(progress) {
            progressView.width = self.width * CGFloat(progress)
        }
    }
}

extension NSProgressView {
    enum Style {
        case `default`
    }
}

extension NSProgressView {
    func setProgress(_ progress: Float, animated: Bool) {
        self.progress = progress
        let  duration = animated ? 0.2 : 0
        NSAnimationContext.runAnimationGroup { (context) in
            context.duration = duration
            progressView.animator().setBoundsSize(NSSize.init(width:self.width * CGFloat(progress), height: self.height))
        }
    }
}
