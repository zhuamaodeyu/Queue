//
//  BuildingTerminalManagerController.swift
//  Queen
//
//  Created by 聂子 on 2019/8/8.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

class BuildingTerminalManagerController: NSViewController {

    private var textView: SyntaxTextView!

    override func loadView() {
        self.view = NSView.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        textView = SyntaxTextView.init()
        view.addSubview(textView)
        textView.snp.makeConstraints { (make) in
            make.edges.equalTo(NSEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
}
