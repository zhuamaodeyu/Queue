//
//  LeftMenuViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/6.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa
import SnapKit

class LeftMenuViewController: NSViewController {

    private var userNameLabel: NSTextField!
    private var userIconImageView: NSImageView!

    private var tableView: NSTableView!

    override func loadView() {
        self.view = NSView.init()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = NSColor.randomColor 
    }
}

extension LeftMenuViewController {
    private func initSubviews() {
        view.addSubview(userIconImageView)
        view.addSubview(userNameLabel)
        view.addSubview(tableView)
    }
    private func initSubviewConstaints() {
        userIconImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(view).offset(80)
        }
        userNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.top.equalTo(userIconImageView.snp.bottom).offset(20)
        }
        tableView.snp.makeConstraints { (make) in
            make.bottom.equalTo(view).offset(-50)
            make.right.left.equalTo(view)
        }
    }
}


extension LeftMenuViewController: NSTableViewDelegate, NSTableViewDataSource {
    func numberOfRows(in tableView: NSTableView) -> Int {
        return 3
    }
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
//        let cell = tableView.make(withIdentifier: "me", owner: self) as! ChatTableCellView
//        cell.dataModel = friendsData[row]
//        return cell
        return NSView.init()
    }
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 0
    }

}
