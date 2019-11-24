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
    private static var menuType:MenuShowType {
        return AppInfo.shared.leftMenuType
    }
    private var menuViewController: MenuViewController = MenuViewController.init(type: MainViewController.menuType)

    private var menuView: NSView!
    private var contentView: ContainerView = ContainerView.init()


}
extension MainViewController {
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
        menuView.snp.updateConstraints { (make) in
            make.width.equalTo(MainViewController.menuType == .all ? 180 : 60)
        }
        super.updateViewConstraints()
    }
}


// MARK: UI
extension MainViewController {
    private func initSubviews() {
        menuView = menuViewController.view

        self.view.addSubview(menuView)
        self.view.addSubview(contentView)
    }
    private func initSubviewConstaints() {
        menuView.snp.makeConstraints({ (make) in
            make.top.left.bottom.equalTo(view)
            make.width.equalTo(MainViewController.menuType == .all ? 180 : 60)
        })
        contentView.snp.makeConstraints({ (make) in
            make.right.top.bottom.equalTo(view)
            make.left.equalTo(menuView.snp.right)
        })
    }
}
// MARK: - MenuViewControllerDelegate
extension MainViewController: MenuViewControllerDelegate {
    func leftMenuViewController(viewController: MenuViewController, tableView: NSTableView?, didSelect type: MenuType) {
        clearViewController()
        contentView.removeAllSubviews()
        switch type {
        case .podManager:
            let  managerViewController = ManagerViewController.init()
            self.contentView.addSubview(managerViewController.view)
            self.addChild(managerViewController)
            break
        case .networkManager:
            let configViewController = ConfigViewController.init()
            self.contentView.addSubview(configViewController.view)
            self.addChild(configViewController)
            break
        case .build:
            let ciManagerViewController = CIManagerViewController.init()
            self.contentView.addSubview(ciManagerViewController.view)
            self.addChild(ciManagerViewController)
            break
        case .document:
            let  documentViewController = DocumentationViewController.init()
            self.contentView.addSubview(documentViewController.view)
            self.addChild(documentViewController)
            break
        case .sourceCache:
            let  buildingViewController = BuildingViewController.init()
            self.contentView.addSubview(buildingViewController.view)
            self.addChild(buildingViewController)
            break
        case .admin:
            let administratorViewController = AdministratorViewController.init()
            self.contentView.addSubview(administratorViewController.view)
            self.addChild(administratorViewController)
        case .buriedPoint:
            let vc = BuriedPointViewController.init()
            self.contentView.addSubview(vc.view)
            self.addChild(vc)
        default:
            break
        }
        self.view.displayIfNeeded()
    }
}

// MARK: - private method
extension MainViewController {
    private func clearViewController() {
        for vc  in self.children {
            if !vc.isKind(of: MenuViewController.self) {
                vc.removeFromParent()
            }
        }
    }
}

protocol MainSubViewControllerProtocol {
    var type: MenuType { get }
}




// MARK: 方式2
//class MainViewController: NSViewController {
//    private struct MenuWdith {
//        static var min:CGFloat = 60
//        static var max:CGFloat = 200
//    }
//
//    private var splitView: NSSplitView!
//    private var containerView: ContainerView!
//
//    private var menuViewController: MenuViewController = MenuViewController.init()
//    private var currentViewController: NSViewController?
//
//    override func loadView() {
//        self.view = NSView.init()
//        installSubviews()
//        initSubController()
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.defaultView()
//    }
//}
//
//extension MainViewController {
//    private func installSubviews() {
//
//        menuViewController.delegate = self
//
//        splitView = NSSplitView.init()
//        splitView.isVertical = true
//        splitView.dividerStyle = .thin
//        splitView.autoresizesSubviews = true
//        splitView.backgroundColor = NSColor.clear
//        splitView.delegate = self
//        splitView.adjustSubviews()
//        view.addSubview(splitView)
//
//        splitView.snp.makeConstraints { (make) in
//            make.edges.equalTo(NSEdgeInsets.zero)
//        }
//        self.addChild(menuViewController)
//
//        splitView.addSubview(menuViewController.view)
//        containerView = ContainerView.init()
//        splitView.addSubview(containerView)
//        self.view.displayIfNeeded()
//    }
//
//    private func initSubController() {
//        let  managerViewController = ManagerViewController.init()
//        self.addChild(managerViewController)
//
//        let configViewController = ConfigViewController.init()
//        self.addChild(configViewController)
//
//        let ciManagerViewController = CIManagerViewController.init()
//        self.addChild(ciManagerViewController)
//
//        let  documentViewController = DocumentationViewController.init()
//        self.addChild(documentViewController)
//
//        let  buildingViewController = BuildingViewController.init()
//        self.addChild(buildingViewController)
//
//        let administratorViewController = AdministratorViewController.init()
//        self.addChild(administratorViewController)
//
//        let buriedPointVC = BuriedPointViewController.init()
//        self.addChild(buriedPointVC)
//    }
//
//    private func defaultView() {
//        self.leftMenuViewController(viewController: menuViewController, tableView: nil, didSelect: .podManager)
//        splitView.setPosition(MenuWdith.max, ofDividerAt: 0)
//    }
//}
//
//extension MainViewController: MenuViewControllerDelegate {
//    func leftMenuViewController(viewController: MenuViewController, tableView: NSTableView?, didSelect type: MenuType) {
////        let vcs = self.children.filter {(($0 as? MainSubViewControllerProtocol)?.type ?? .none) == type}
////        if splitView.subviews.count != 2 {
////            if let v = vcs.first {
////                splitView.addSubview(v.view)
////                self.currentViewController = v
////            }
////        }else {
////            if let vc = vcs.first,let currentVC = currentViewController {
////                self.transition(from: currentVC, to: vc, options: .slideUp, completionHandler: {
////                    self.currentViewController = vc
////                })
////            }
////        }
//        let vcs = self.children.filter {(($0 as? MainSubViewControllerProtocol)?.type ?? .none) == type}
//        if let vc = vcs.first {
//            containerView.removeAllSubviews()
//            containerView.addSubview(vc.view)
//            self.currentViewController = vc
//        }
//    }
//}
//extension MainViewController : NSSplitViewDelegate {
//    func splitView(_ splitView: NSSplitView, constrainMinCoordinate proposedMinimumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
//        return MenuWdith.min
//    }
//    func splitView(_ splitView: NSSplitView, constrainMaxCoordinate proposedMaximumPosition: CGFloat, ofSubviewAt dividerIndex: Int) -> CGFloat {
//        return MenuWdith.max
//    }
//    func splitViewDidResizeSubviews(_ notification: Notification) {
//
//    }
//    func splitView(_ splitView: NSSplitView, resizeSubviewsWithOldSize oldSize: NSSize) {
//        let oldWidth = splitView.arrangedSubviews.first?.width ?? 100
//        splitView.adjustSubviews()
//        splitView.setPosition(oldWidth, ofDividerAt: 0)
//    }
//}
