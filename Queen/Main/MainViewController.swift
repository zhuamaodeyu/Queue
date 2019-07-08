//
//  MainViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/5.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa
import SnapKit

class MainViewController: NSViewController {

    private var leftViewController: LeftMenuViewController = LeftMenuViewController.init()
    private var rightViewController: RightContentViewController = RightContentViewController.init()

    override func viewDidLoad() {
        super.viewDidLoad()
        initSubviews()
        initSubviewConstaints()
    }
}

extension MainViewController {
    private func initSubviews() {
        self.view.addSubview(leftViewController.view)
        self.view.addSubview(rightViewController.view)
        self.addChild(leftViewController)
        self.addChild(rightViewController)
    }
    private func initSubviewConstaints() {
        leftViewController.view.snp.makeConstraints({ (make) in
            make.top.left.bottom.equalTo(view)
            make.width.equalTo(200)
        })
        rightViewController.view.snp.makeConstraints({ (make) in
            make.right.top.bottom.equalTo(view)
            make.left.equalTo(leftViewController.view.snp.right)
        })
    }
}
