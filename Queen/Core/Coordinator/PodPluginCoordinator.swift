//
//  PodPluginCoordinator.swift
//  Queen
//
//  Created by 聂子 on 2019/7/31.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa

struct PodPluginModel {

}

class PodPluginCoordinator: NSObject {
    var installedPlugins = [PodPluginModel]()

    private var installCommandLine:CommandLine?
    

    func getPlugin(_ callback: (([PodPluginModel])->())? = nil) {

    }

    func installPlugins(names:[String]) {
        
    }
}
