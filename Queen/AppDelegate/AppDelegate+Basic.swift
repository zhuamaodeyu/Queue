//
//  AppDelegate+Basic.swift
//  Queen
//
//  Created by 聂子 on 2019/8/3.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa
import LeanCloud

// MARK: - init 
extension AppDelegate {
    static func initialSettings() {
        let defaults = DefaultSettings.defaults.mapKeys { $0.rawValue }
        UserDefaults.standard.register(defaults: defaults)
        NSUserDefaultsController.shared.initialValues = defaults

        ProgressHUD.setDefaultStyle(.dark)
        ProgressHUD.setDefaultPosition(.center)
    }

    static func initLeanCloud() {
        LCApplication.logLevel = .all
        do {
            try LCApplication.default.set(
                id: "8B9PpR2PlW8msf33yoGik2uO-MdYXbMMI",
                key: "fGrV7MkKgwpT7JRs0vFcVBma"
            )
        } catch {
            fatalError("\(error)")
        }
    }

    private func registerLeanCloudEntity() {
        UserEntity.register()
        UserFindEntity.register()
        UserClientASssociation.register()
        ProjectTeamEntity.register()
        PodSpecEntity.register()
        PodDescriptionEntity.register()
    }
}

extension AppDelegate {

}

