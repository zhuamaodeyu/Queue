//
//  ManagerViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/8.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa


class ManagerViewController: NSViewController {

    private lazy var podContactVC = PodContactViewController.init()
    private lazy var podMessageVC = PodMessageViewController.init()

    private var topView: MainContentTopMenuView!
    private var containerView: NSView = NSView.init()


    private var isShowMapping: Bool = false
}

extension ManagerViewController {
    override func loadView() {
        self.view = NSView.init()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        installSubviews()
        containerView.addSubview(podMessageVC.view)
        self.view.displayIfNeeded()
        self.addChild(podContactVC)
        self.addChild(podMessageVC)
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        if let view = containerView.subviews.first {
            view.frame = CGRect.init(origin: CGPoint.zero, size: self.containerView.frame.size)
        }
    }
}

extension ManagerViewController: MainSubViewControllerProtocol {
    var type: MenuType {
        return .podManager
    }
}
extension ManagerViewController {
    private func installSubviews() {
        view.addSubview(containerView)

        topView = MainContentTopMenuView.init()
        topView.config(complation: topMenuComplation())
        view.addSubview(topView)

        topView.snp.makeConstraints { (make) in
            make.top.right.left.equalTo(view)
            make.height.equalTo(80)
        }
        containerView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(topView.snp.bottom)
        }
    }
}


extension ManagerViewController {
    private func topMenuComplation() -> ((NSView, TopViewButtonType) -> Void)? {
        return { (sender: NSView, type: TopViewButtonType) in

            switch type {
            case .reload:
                break
            case .build:
                break
            case .stop:
                break
            case .mapping:
                if self.isShowMapping {
                    self.transition(from: self.podContactVC, to: self.podMessageVC, options: .slideRight, completionHandler: {
                        self.isShowMapping = false
                    })
                }else {
                    self.transition(from: self.podMessageVC, to: self.podContactVC, options: .slideLeft, completionHandler: {
                        self.isShowMapping = true
                    })
                }
                break
            case .pod_install:
                break
            case .pod_update:
                break
            case .pod_searach:
                break
            case .vscode:
                break
            case .xcode:
                break
            case .floder:
                break
            default:
                break
            }
        }
    }


}
