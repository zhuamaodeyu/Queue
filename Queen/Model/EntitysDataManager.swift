//
//  EntitysDataManager.swift
//  Queen
//
//  Created by 聂子 on 2019/8/3.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation
import LeanCloud

class EntitysDataManager {
    static let instance = EntitysDataManager.init()

    // 当前用户所在的项目组
    private(set) var projectTeam:[ProjectTeamEntity] = []
    //当前用户可访问的 spec 源
    private(set) var podSpecs:[PodSpecEntity] = []

    private init() {

    }
}

extension EntitysDataManager {
    func reload() {
        getProjectTeam()
        getPodSpecs()
    }
}


extension EntitysDataManager {
    private func getProjectTeam() {
        let user = LCApplication.default.currentUser as? UserEntity
        let query = LCQuery.init(application: LCApplication.default, className: ProjectTeamEntity.objectClassName())
        query.whereKey("objectId", .equalTo(user?.teamId ?? []))
        query.find { (result) in

        }
    }

    private func getPodSpecs(){

    }

}
