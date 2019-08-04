//
//  NSAlert+Exts.swift
//  Queen
//
//  Created by 聂子 on 2019/8/4.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa


extension NSAlert {
    static func alert(stye:NSAlert.Style,
                      message: String,
                      information:String,
                      button titles:[String], complation:(Bool) ->Void) {

        let alert = NSAlert.init()
        alert.messageText = message
        alert.informativeText = information
        alert.alertStyle = stye
        titles.forEach { (t) in
            alert.addButton(withTitle: t)
        }
        complation(alert.runModal().rawValue == NSAlertDefaultReturn)

    }
}
