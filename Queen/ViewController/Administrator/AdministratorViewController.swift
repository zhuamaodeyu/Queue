//
//  AdministratorViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/26.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

enum AdministratorActionType:Int {
    case none
    case user
    case team
    case spec
}
struct AdministratorMenuModel {
     var type: AdministratorActionType = .none
     var name: String
     var icon: String
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

    override func loadView() {
        self.view = NSView.init()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        installSubviews()
        menuDataSource.append(AdministratorMenuModel.init(type: .spec, name: "Spec", icon: ""))
        menuDataSource.append(AdministratorMenuModel.init(type: .team, name: "Team", icon: ""))
        menuDataSource.append(AdministratorMenuModel.init(type: .user, name: "User", icon: ""))
    }
}

extension AdministratorViewController {

    private func installSubviews() {
        self.menuView = AdministratorMenuView.init()
        self.menuView.delegate = self
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
    }
}


extension AdministratorViewController: AdministratorMenuViewDelegate {
    func menuView(_ menuView: AdministratorMenuView, didSelectRowAt indexPath: Int) {
        guard let model = self.menuDataSource[safe: indexPath] else {
            return
        }
        switch model.type {
        case .user:
            break
        case .team:
            break
        case .spec:
            break
        default:
            break
        }
    }
}
extension AdministratorViewController: AdministratorMenuViewDataSource {
    func numberOfSections(in menuView: AdministratorMenuView) -> Int {
        return menuDataSource.count
    }
    func menuView(_ menuView: AdministratorMenuView, cellForRowAt indexPath: Int) -> NSView? {
        let model = self.menuDataSource[indexPath]
        let cell = AdministratorMenuCell.init()
        
        return nil
    }
}

extension AdministratorViewController:  ContentContainterViewDelegate {
    func contentContainterView(_ containterView: ContentContainterView,with type:AdministratorActionType, submitButtonClick model: ContentContaiterViewModel) {

    }
}

