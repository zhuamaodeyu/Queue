//
//  Models.swift
//  Queen
//
//  Created by 聂子 on 2019/7/24.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation

enum NodePositionType {
    case auto
    case left
    case right
}

class QMNode {
    var nodeId: String = ""
    var root:Bool = false
    var positionType: NodePositionType = .auto
    weak var prsent: QMNode?
    private(set) var children:[QMNode] = []
}
extension QMNode {
    func addChildren(node:QMNode) {
        self.children.append(node)
    }
    func removeChildren(nodeId:String) {
        self.children.removeAll { (m) -> Bool in
            m.nodeId == nodeId
        }
    }
}
