//
//  BuriedPointViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/9/28.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class BuriedPointViewController: NSViewController {

    private var splitView: NSSplitView = NSSplitView.init()
    
}

extension BuriedPointViewController {
    private struct SplitSize {
          static var min: CGFloat = 200
          static var max: CGFloat = 350
      }
}


extension BuriedPointViewController {
    override func loadView() {
        self.view = NSView.init()
        installSubviews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

extension BuriedPointViewController : MainSubViewControllerProtocol {
    var type: MenuType {
        return .buriedPoint
    }
}


extension BuriedPointViewController {
    private func installSubviews() {
        splitView.isVertical = true
        splitView.dividerStyle = .thin
        splitView.autoresizesSubviews = true
        splitView.backgroundColor = NSColor.clear
        splitView.delegate = self
        splitView.adjustSubviews()
        view.addSubview(splitView)

        
        let treeVC = BuriedTreeViewController.init()
        let editAndShowVC = BuriedShowAndEditViewController.init()
        splitView.addSubview(treeVC.view)
        splitView.addSubview(editAndShowVC.view)

        self.addChild(treeVC)
        self.addChild(editAndShowVC)

        splitView.snp.makeConstraints { (make) in
            make.edges.equalTo(NSEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
}



extension BuriedPointViewController : NSSplitViewDelegate {
    //    允许为NSSplitView的子视图指定自定义大小行为sender。
    func splitView(_ splitView: NSSplitView, resizeSubviewsWithOldSize oldSize: NSSize) {
        if splitView.subviews.count == 0 {
            return
        }
        if oldSize.equalTo(CGSize.zero) {
            for (index, item) in splitView.subviews.enumerated() {
                
                item.setFrameSize(NSSize.init(width: index == 0 ? SplitSize.min : splitView.width - SplitSize.min, height: splitView.height))
                item.setFrameOrigin(NSPoint.init(x: index == 0 ? 0: SplitSize.min, y: 0))
            }
        }
        let oldWidth = splitView.arrangedSubviews.first?.frame.size.width ?? 0
        splitView.adjustSubviews()
        splitView.setPosition(oldWidth, ofDividerAt: 0)
    }

    // 此处返回的不是一个恒定的值，会根据变化而变化的值
    func splitView(_ splitView: NSSplitView, constrainMaxCoordinate proposedMaximumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        if dividerIndex == 0 {
            return SplitSize.max
        }
        return proposedMaximumPosition
    }

    func splitView(_ splitView: NSSplitView, constrainMinCoordinate proposedMinimumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        
        if dividerIndex == 0 {
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
