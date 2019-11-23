//
//  ComponentModel.swift
//  Queen
//
//  Created by 聂子 on 2019/7/9.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation

// 组件
struct ComponentModel {
    var id: String
    var name: String
    var hasDoc: String
    var desc: String
    var version: String
    var binaray: Bool
    var from: String
    var manager: String
    var test: Bool
    var collection: Bool
    var building: Bool
    var lastBuilding: String
    var lastBuilder: String

    // 本地路径
    var frameworkLocalPath: String?
    var sourceLocalPath: String?
}
