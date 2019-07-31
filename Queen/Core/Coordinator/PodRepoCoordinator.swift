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
    func getSourceRepos(_ callback: (([PodRepoModel])->())? = nil) {

    }

    func cocoaPodsSpecSort(_ lhs: PodRepoModel, rhs: PodRepoModel) -> Bool {
        return false 
    }
}
