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

    private var menuView: NSView!
    private var contentView: ContainerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        menuViewController.delegate = self
        initSubviews()
        initSubviewConstaints()
    }

    override func viewWillAppear() {
        super.viewWillAppear()
    }
    override func viewDidAppear() {
        super.viewDidAppear()
    }

    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
}

extension MainViewController {
    private func initSubviews() {
        menuView = menuViewController.view

        contentView = ContainerView.init()

        self.view.addSubview(menuView)
        self.view.addSubview(contentView)
    }
    private func initSubviewConstaints() {
        menuView.snp.makeConstraints({ (make) in
            make.top.left.bottom.equalTo(view)
            make.width.equalTo(180)
        })
        contentView.snp.makeConstraints({ (make) in
            make.right.top.bottom.equalTo(view)
            make.left.equalTo(menuView.snp.right)
        })
    }
}

extension MainViewController: MenuViewControllerDelegate {
    func leftMenuViewController(viewController: MenuViewController, tableView: NSTableView, didSelect row: Int) {
        clearViewController()
        contentView.removeAllSubviews()
        switch row {
        case 0:
            let  managerViewController = ManagerViewController.init()
            self.contentView.addSubview(managerViewController.view)
            self.addChild(managerViewController)
            break
        case 1:
            let configViewController = ConfigViewController.init()
            self.contentView.addSubview(configViewController.view)
            self.addChild(configViewController)
            break
        case 2:
            let ciManagerViewController = CIManagerViewController.init()
            self.contentView.addSubview(ciManagerViewController.view)
            self.addChild(ciManagerViewController)
            break
        case 3:
            let  documentViewController = DocumentationViewController.init()
            self.contentView.addSubview(documentViewController.view)
            self.addChild(documentViewController)
            break
//        case 4:
//            let  buildingViewController = BuildingViewController.init()
//            self.contentView.addSubview(buildingViewController.view)
//            self.addChild(buildingViewController)
//            break
        case 4:
            let administratorViewController = AdministratorViewController.init()
            self.contentView.addSubview(administratorViewController.view)
            self.addChild(administratorViewController)
        default:
            break
        }
        self.view.displayIfNeeded()
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
