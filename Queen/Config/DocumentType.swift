//
//  DocumentType.swift
//  Queen
//
//  Created by 聂子 on 2019/7/16.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation

struct DocumentType {
    let extensions : [String]

    static let `default` = DocumentType.init(extensions: ["queue"])
}



// Documentation Notification keys
struct DocumentationAssociatedKey {
    static var url = "url"
    static var name = "name"
}

struct DocumentAssociatedKeys {
    // 根
    static var qworkspace = "qworkspace"
    //
    static var poddata = "poddata"
    // 配置
    static var config = "config"
    // 图
    static var mapping = "mapping"
}
