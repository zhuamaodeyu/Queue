//
//  AdministratorViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/26.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

private struct Identifiter {
    static var MenuViewCellIdentifiter = NSUserInterfaceItemIdentifier.init("MenuViewCellIdentifiter")
}

enum AdministratorActionType:Int {
    case none
    // 用户管理
    case user
    // team 管理
    case team
    // spec 管理
    case spec
}
class AdministratorMenuModel {
    var type: AdministratorActionType = .none
    var name: String = ""
    var icon: String = ""
    var select: Bool = false
    init(type:AdministratorActionType = .none, name: String, icon: String, select: Bool = false) {
        self.type = type
        self.name = name
        self.icon = icon
        self.select = select
    }
}

class AdministratorViewController: NSViewController {

    /**
     1. 创建用户
     2. 创建项目组
     3. 创建spec 仓库
     */
    private var menuView: AdministratorMenuView!
    private var containterView: ContentContainterView!

    private var menuDataSource:[AdministratorMenuModel] = []

    private var currentShowViewController: NSViewController?

    override func loadView() {
        self.view = NSView.init()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        installSubviews()
        menuDataSource.append(AdministratorMenuModel.init(type: .spec, name: "Spec", icon: "", select: false))
        menuDataSource.append(AdministratorMenuModel.init(type: .team, name: "Team", icon: "", select: false))
        menuDataSource.append(AdministratorMenuModel.init(type: .user, name: "User", icon: "", select: false))
        menuView.reloadData()
    }
}
extension AdministratorViewController : MainSubViewControllerProtocol {
    var type: MenuType {
        return .admin
    }
}

extension AdministratorViewController {

    private func installSubviews() {
        self.menuView = AdministratorMenuView.init()
        self.menuView.delegate = self
        self.menuView.dataSource = self
        self.menuView.register(AdministratorMenuCell.self, forItemWithIdentifier: NSUserInterfaceItemIdentifier.init(AdministratorMenuCell.className()))
        self.view.addSubview(menuView)

        self.containterView = ContentContainterView.init()
        containterView.delegate = self
        self.view.addSubview(containterView)

        menuView.snp.makeConstraints { (make) in
            make.right.top.bottom.equalTo(self.view)
            make.width.equalTo(50)
        }
        containterView.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self.view)
            make.right.equalTo(menuView.snp.left)
        }
        
        let userAdminVC = AdminUserManagerController.init()
        self.addChild(userAdminVC)
        let teamAdminVC = AdminTeamManagerController.init()
        self.addChild(teamAdminVC)
        let specAdminVC = AdminSpecManagerController.init()
        self.addChild(specAdminVC)

    }
}


extension AdministratorViewController: AdministratorMenuViewDelegate {
    func menuView(_ menuView: AdministratorMenuView, didSelectRowAt indexPath: Int) {
        debugPrint("=========Select: \(indexPath)")
        guard let model = self.menuDataSource[safe: indexPath] else {
            return
        }
        let currentItem = self.menuDataSource.filter {$0.select}.first
        model.select = true
        currentItem?.select = false

        var toViewController: NSViewController? = nil
        switch model.type {
        case .user:
            toViewController = self.children.filter { (($0 as? AdminUserManagerController) != nil) ? true : false }.first
            break
        case .team:
            toViewController = self.children.filter { (($0 as? AdminTeamManagerController) != nil) ? true : false }.first
            break
        case .spec:
            toViewController = self.children.filter { (($0 as? AdminSpecManagerController) != nil) ? true : false }.first
            break
        default:
            break
        }

        toViewController?.view.frame = containterView.bounds

        if self.currentShowViewController == nil, let viewController = toViewController {
            containterView.addSubview(viewController.view)
            self.currentShowViewController = viewController
            self.menuView.reloadData()
            return
        }

        guard let viewController = toViewController, let currentViewController = self.currentShowViewController else {
            return
        }

        if viewController == currentViewController {
            return
        }

        self.transition(from: currentViewController, to: viewController, options: .slideDown, completionHandler: {[weak self] in
            self?.currentShowViewController = viewController
        })
        self.menuView.reloadData()
    }
}
extension AdministratorViewController: AdministratorMenuViewDataSource {
    func numberOfSections(in menuView: AdministratorMenuView) -> Int {
        return menuDataSource.count
    }
    func menuView(_ menuView: AdministratorMenuView, cellForRowAt indexPath: Int) -> NSCollectionViewItem? {
        let cell  = menuView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier.init(AdministratorMenuCell.className()), for: indexPath) as? AdministratorMenuCell
        cell?.config(model: menuDataSource[indexPath])
        return cell
    }
    func menuView(_ menuView: AdministratorMenuView, cell size: IndexPath) -> NSSize? {
        return CGSize.init(width: menuView.width, height: menuView.width)
    }
}

extension AdministratorViewController:  ContentContainterViewDelegate {
    func contentContainterView(_ containterView: ContentContainterView,with type:AdministratorActionType, submitButtonClick model: ContentContaiterViewModel) {

    }
}

