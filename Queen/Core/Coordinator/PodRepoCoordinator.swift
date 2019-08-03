//
//  PodRepoCoordinator.swift
//  Queen
//
//  Created by 聂子 on 2019/7/31.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

struct PodRepoModel {

}

class PodRepoCoordinator: NSObject {
    private var successBlock:((_ models:PodAnalyzerModel) -> Void)?
    private var logBlock:((_ log: NSAttributedString) -> Void)?
    private var commandLines:[CommandLine] = []
}


extension PodRepoCoordinator {

    /// 获取所有的 source Repo
    ///
    /// - Parameter callback: callback
    func sourceRepos(_ callback: (([PodRepoModel])->())? = nil) {

    }

    func cocoaPodsSpecSort(_ lhs: PodRepoModel, rhs: PodRepoModel) -> Bool {
        return false
    }

    func update() {
        
    }
}


extension PodRepoCoordinator {
    private func checkUpdate() -> Bool {
        return false
    }
}
