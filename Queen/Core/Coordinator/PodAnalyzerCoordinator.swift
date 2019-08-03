//
//  PodAnalyzerCoordinator.swift
//  Queen
//
//  Created by 聂子 on 2019/7/31.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa


struct PodAnalyzerModel {

}

class PodAnalyzerCoordinator: NSObject {
    private var successBlock:((_ models:PodAnalyzerModel) -> Void)?
    private var logBlock:((_ log: NSAttributedString) -> Void)?
    private var commandLine:CommandLine?
    
}
