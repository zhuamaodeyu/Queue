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
    private(set) var teams:[TeamEntity] = []
    //当前用户可访问的 spec 源
    private(set) var specSources:[SpecSourceEntity] = []

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
        let query = LCQuery.init(className: TeamEntity.objectClassName())
        guard let userId = LCApplication.default.currentUser?.objectId else {
            return
        }
        query.whereKey("member_ids", .containedIn([userId]))
        let result = query.find()
        if result.isSuccess , let objects = result.objects as? [TeamEntity] {
            self.teams = objects
        }
    }

    private func getPodSpecs(){
        var teams = Set<String>.init()
        for team in self.teams {
            teams.update(with: team.objectId?.stringValue ?? "")
        }

        let query = LCQuery.init(className: SpecSourceEntity.objectClassName())
        query.whereKey("team", .containedIn(Array(teams)))
        query.whereKey("team", .notExisted)
        query.whereKey("public", .equalTo(LCBool.init(true)))
        let result = query.find()
        if result.isSuccess , let objects = result.objects as? [SpecSourceEntity] {
            self.specSources = objects
        }
    }

}
