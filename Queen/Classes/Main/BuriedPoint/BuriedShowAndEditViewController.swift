//
//  BuriedShowAndEditViewController.swift
//  Queen
//
//  Created by 聂子 on 2020/2/2.
//  Copyright © 2020 聂子. All rights reserved.
//

import Cocoa

class BuriedShowAndEditViewController: NSViewController {

    private var splitView: NSSplitView = NSSplitView.init()
}

extension BuriedShowAndEditViewController {
    private struct SplitSize {
          static var min: CGFloat = 300
          static var max: CGFloat = 450
      }
}

extension BuriedShowAndEditViewController {
    override func loadView() {
        self.view = NSView.init()
        installSubviews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension BuriedShowAndEditViewController {
    private func installSubviews() {
         splitView.isVertical = true
           splitView.dividerStyle = .thin
           splitView.autoresizesSubviews = true
           splitView.backgroundColor = NSColor.clear
           splitView.delegate = self
           splitView.adjustSubviews()
           view.addSubview(splitView)

        
        let showVC = BuriedPointShowViewController.init()
        let editVC = BuriedPointEditViewController.init()
        splitView.addSubview(showVC.view)
        splitView.addSubview(editVC.view)

        self.addChild(showVC)
        self.addChild(editVC)

        splitView.snp.makeConstraints { (make) in
            make.edges.equalTo(NSEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
}



extension BuriedShowAndEditViewController : NSSplitViewDelegate {
    //    允许为NSSplitView的子视图指定自定义大小行为sender。
    func splitView(_ splitView: NSSplitView, resizeSubviewsWithOldSize oldSize: NSSize) {
        if splitView.subviews.count == 0 {
            return
        }
        
        if oldSize.equalTo(CGSize.zero) {
            for (index, item) in splitView.subviews.enumerated() {
                item.setFrameSize(NSSize.init(width: index == 1 ? SplitSize.min : splitView.width - SplitSize.min, height: splitView.height ))
                item.setFrameOrigin(NSPoint.init(x: index == 1 ? 0: SplitSize.min, y: 0))
            }
        }
        let oldWidth = splitView.arrangedSubviews.last?.frame.size.width ?? 0
        debugPrint("=============\(splitView.width - oldWidth)")
        splitView.adjustSubviews()
        splitView.setPosition(oldWidth, ofDividerAt: 1)
    }

//    // 此处返回的不是一个恒定的值，会根据变化而变化的值
    func splitView(_ splitView: NSSplitView, constrainMaxCoordinate proposedMaximumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        if dividerIndex == 1 {
            return SplitSize.max
        }
        return proposedMaximumPosition
    }

    func splitView(_ splitView: NSSplitView, constrainMinCoordinate proposedMinimumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        if dividerIndex == 1 {
            return SplitSize.min
        }
        return proposedMinimumPosition
    }
    func splitView(_ splitView: NSSplitView, canCollapseSubview subview: NSView) -> Bool {
        return false
    }
    func splitView(_ splitView: NSSplitView, shouldAdjustSizeOfSubview view: NSView) -> Bool {
        return false
    }
}
