//
//  ContainerView.swift
//  Queen
//
//  Created by 聂子 on 2019/7/11.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class ContainerView: NSView {

}

// MARK: system function 
extension ContainerView {
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    }
    
    
    override func addSubview(_ view: NSView) {
        if self.subviews.count >= 1 {
            return
        }
        super.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.edges.equalTo(NSEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        }
    }

}
