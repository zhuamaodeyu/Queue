//
//  AppDelegate.swift
//  Queen
//
//  Created by 聂子 on 2019/7/5.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa
import LetsMove


@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    lazy var loginWindowController: LoginWindowController? = {
        guard let loginWindowController = NSStoryboard.windowController(name: "LoginWindowController", storyboard: "Login") as? LoginWindowController else {
            return nil
        }
        return loginWindowController
    }()

    lazy var welcomeWindowController: WelcomeWindowController? = {
        guard let welcomeWindowController = NSStoryboard.windowController(name: "WelcomeWindowController", storyboard: "Welcome") as? WelcomeWindowController else {
            return nil
        }
        return welcomeWindowController
    }()


    override init() {
        AppDelegate.initialSettings()

        _ = DocumentController.shared
        AppDelegate.initLeanCloud()
        super.init()
    }
}
extension AppDelegate {
    func applicationWillFinishLaunching(_ notification: Notification) {
        #if DEBUG
        #else
            PFMoveToApplicationsFolderIfNecessary()
        #endif
    }
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        registerNotification()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        //即将终止
    }
    func applicationWillBecomeActive(_ notification: Notification) {
        debugPrint("\(#function)")
    }
//    只要Finder重新激活已在运行的应用程序，就会发送这些事件，因为有人再次双击它或使用Dock激活它。
//    默认情况下，Application Kit将通过检查是否存在任何可见的NSWindow（而不是NSPanel）对象来处理此事件，如果没有，则会通过标准的无标题文档创建（与在没有任何应用程序的情况下启动应用程序时相同）要打开的文件）。对于大多数基于文档的应用程序，将创建无标题文档。
//    应用程序委托还将有机会响应正常的无标题文档委托方法。如果在应用程序委托中实现此方法，则会在发生任何默认行为之前调用它。如果返回true，则NSApplication将正常进行。如果返回false，则NSApplication将不执行任何操作。因此，您可以使用不执行任何操作的版本实现此方法，如果您根本不希望发生任何事情，则返回false（不推荐），或者您可以实现此方法，以某种自定义方式自行处理事件，以及返回false。
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        return true
    }
}

