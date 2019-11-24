//
//  DefaultSettings.swift
//  Queen
//
//  Created by 聂子 on 2019/7/16.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation


struct DefaultSettings {
    static let defaults : [DefaultKeys: Any] = [
        .leftMenuType: MenuShowType.all.hashValue
        ]

    
    private init(){

    }
}

