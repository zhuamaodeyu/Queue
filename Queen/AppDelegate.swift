//
//  AppDelegate.swift
//  Queen
//
//  Created by 聂子 on 2019/7/5.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        registerNotification()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}


// MARK: - private
extension AppDelegate {
    private func registerNotification() {
        NSUserNotificationCenter.default.delegate = self
    }
}



// MARK: - NSUserNotificationCenterDelegate
extension AppDelegate : NSUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: NSUserNotificationCenter, didDeliver notification: NSUserNotification) {

    }
    func userNotificationCenter(_ center: NSUserNotificationCenter, didActivate notification: NSUserNotification) {

    }
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
}
