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

    private var menuViewController: MenuViewController = MenuViewController.init()

//    private var ciManagerViewController = CIManagerViewController.init()
//    private var documentViewController = DocumentationViewController.init()
//    private var configViewController = ConfigViewController.init()
//    private var buildingViewController = BuildingViewController.init()

    private var menuView: NSView?
    private var contentView: NSView?

    override func viewDidLoad() {
        super.viewDidLoad()
        initSubviews()
        initSubviewConstaints()
    }
}

extension MainViewController {
    private func initSubviews() {
        menuViewController.delegate = self
        menuView = menuViewController.view
        contentView = ManagerViewController.init().view
        self.view.addSubview(menuView!)
        self.view.addSubview(contentView!)
//        self.addChild(leftViewController)
//        self.addChild(rightViewController)
    }
    private func initSubviewConstaints() {
        menuView?.snp.makeConstraints({ (make) in
            make.top.left.bottom.equalTo(view)
            make.width.equalTo(200)
        })
        contentView?.snp.makeConstraints({ (make) in
            make.right.top.bottom.equalTo(view)
            make.left.equalTo(menuView?.snp.right ?? self.view)
        })
    }
}

extension MainViewController: MenuViewControllerDelegate {
    func leftMenuViewController(viewController: MenuViewController, tableView: NSTableView, didSelect row: Int) {
        switch row {
        case 0:
            let  managerViewController = ManagerViewController.init()
            self.contentView = managerViewController.view
            clearViewController()
            self.addChild(managerViewController)
            break
        case 1:
            let configViewController = ConfigViewController.init()
            self.contentView = configViewController.view
            clearViewController()
            self.addChild(configViewController)
            break
        case 2:
            let  ciManagerViewController = CIManagerViewController.init()
            self.contentView = ciManagerViewController.view
            clearViewController()
            self.addChild(ciManagerViewController)
            break
        case 3:
            let  documentViewController = DocumentationViewController.init()
            self.contentView = documentViewController.view
            clearViewController()
            self.addChild(documentViewController)
            break
        case 4:
            let  buildingViewController = BuildingViewController.init()
            self.contentView = buildingViewController.view
            clearViewController()
            self.addChild(buildingViewController)
            break

        default:
            break
        }
    }
}


extension MainViewController {
    private func clearViewController() {
        for vc  in self.children {
            if !vc.isKind(of: MenuViewController.self) {
                vc.removeFromParent()
            }
        }
    }
}
