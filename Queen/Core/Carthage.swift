//
//  Carthage.swift
//  Queen
//
//  Created by 聂子 on 2019/7/14.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa


private var carthagePath = Command.shared.which(command: "carthage")
class Carthage {
    private var path: String
     init?() {
        if let p = carthagePath {
            self.path = p
            return
        }
        return nil
    }
}
