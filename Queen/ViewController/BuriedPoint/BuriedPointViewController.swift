//
//  BuriedPointViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/9/28.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class BuriedPointViewController: NSViewController {

    private var splitView: NSSplitView!
    
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
        splitView = NSSplitView.init()
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


extension BuriedPointViewController : NSSplitViewDelegate {
    //    func splitView(_ splitView: NSSplitView, constrainMinCoordinate proposedMinimumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
    //        if dividerIndex == 1 {
    //            return 200
    //        }
    //        return 500
    //    }
    func splitView(_ splitView: NSSplitView, constrainMaxCoordinate proposedMaximumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
        return splitView.frame.width - 100
    }
}
