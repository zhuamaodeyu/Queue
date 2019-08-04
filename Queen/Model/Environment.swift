//
//  Environment.swift
//  Queen
//
//  Created by 聂子 on 2019/8/4.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation

struct Environment {
    enum EnvType:String {
        case none
        case RUBYOPT
        case RUBYLIB
        case PATH
        case GEM_HOME
        case GEM_PATH
        case GEM_CACHE
    }

    var RUBYOPT: String = ""
    var RUBYLIB: String = ""
    var PATH: String = ""
    var GEM_HOME: String = ""
    var GEM_PATH: String = ""
    var GEM_CACHE: String = ""
}
