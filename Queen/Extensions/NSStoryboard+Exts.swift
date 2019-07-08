//
//  NSStoryboard+Exts.swift
//  Queen
//
//  Created by 聂子 on 2019/7/6.
//  Copyright © 2019 聂子. All rights reserved.
//

import Foundation
import Cocoa

extension NSStoryboard {

    public static func viewController(from storyboard: String, bundle: Bundle? = nil) -> NSViewController? {
        return NSStoryboard.init(name: storyboard, bundle: bundle).instantiateInitialController() as? NSViewController
    }

    public static func windowController(from storyboard: String, bundle: Bundle? = nil) -> NSWindowController? {
        return NSStoryboard.init(name: storyboard, bundle: bundle).instantiateInitialController() as? NSWindowController
    }

    public static func viewController(name: String, from storyboard: String, bundle: Bundle? = nil) -> NSViewController? {
        return NSStoryboard.init(name: storyboard, bundle: bundle).instantiateController(withIdentifier: name) as? NSViewController
    }

    public static func windowController(name: String,from storyboard: String, bundle: Bundle? = nil) -> NSWindowController? {
        return NSStoryboard.init(name: storyboard, bundle: bundle).instantiateController(withIdentifier: name) as? NSWindowController
    }
}
