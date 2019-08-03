//
//  Appdelegate+Notification.swift
//  Queen
//
//  Created by 聂子 on 2019/8/3.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa



// MARK: - NSUserNotificationCenterDelegate
extension AppDelegate : NSUserNotificationCenterDelegate {

    func registerNotification() {
        NSUserNotificationCenter.default.delegate = self
    }
    func userNotificationCenter(_ center: NSUserNotificationCenter, didDeliver notification: NSUserNotification) {

    }
    func userNotificationCenter(_ center: NSUserNotificationCenter, didActivate notification: NSUserNotification) {

    }
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
}
