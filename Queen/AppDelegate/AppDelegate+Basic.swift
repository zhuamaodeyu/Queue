//
//  AppDelegate+Basic.swift
//  Queen
//
//  Created by 聂子 on 2019/8/3.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa
import LeanCloud

// MARK: - init 
extension AppDelegate {
    static func initialSettings() {
        let defaults = DefaultSettings.defaults.mapKeys { $0.rawValue }
        UserDefaults.standard.register(defaults: defaults)
        NSUserDefaultsController.shared.initialValues = defaults

//        ProgressHUD.setDefaultStyle(.dark)
//        ProgressHUD.setDefaultPosition(.center)
    }

    static func initLeanCloud() {
        LCApplication.logLevel = .off
        do {
            try LCApplication.default.set(
                id: "8B9PpR2PlW8msf33yoGik2uO-MdYXbMMI",
                key: "fGrV7MkKgwpT7JRs0vFcVBma"
            )
        } catch {
            fatalError("\(error)")
        }
    }

    static func registerLeanCloudEntity() {
        UserEntity.register()
        UserFindEntity.register()
        UserClientASssociation.register()

        TeamEntity.register()
        SpecSourceEntity.register()
        PodDescriptionEntity.register()
    }

    // 初始化 CocoaPods 对象，然后会读取一些数据
    func initCocoaPodsBasicData() {
       _ =  Cocoapods.instance
    }
}

extension AppDelegate {
    private func showWelcomeWindow() {
        guard let welcomeWindowController = NSStoryboard.windowController(name: "WelcomeWindowController", storyboard: "Welcome") as? WelcomeWindowController else {
            return
        }
        welcomeWindowController.window?.center()
        welcomeWindowController.window?.makeKeyAndOrderFront(nil)
    }

    private func showLoginWindow() {
        guard let loginWindowController = NSStoryboard.windowController(name: "LoginWindowController", storyboard: "Login") as? LoginWindowController else {
            return
        }
        loginWindowController.window?.center()
        loginWindowController.window?.makeKeyAndOrderFront(nil)
    }

    func showWindow() {
        showWelcomeWindow()
        return
        
        if NSApp.orderedWindows.count > 0 || NSApp.orderedDocuments.count > 0 {
            return
        }
        if let _  = LCApplication.default.currentUser {
            EntitysDataManager.instance.reload()
            showWelcomeWindow()
        }else {
            showLoginWindow()
        }
    }

}

