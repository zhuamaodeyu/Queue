//
//  DocumentationViewController.swift
//  Queen
//
//  Created by 聂子 on 2019/7/10.
//  Copyright © 2019 聂子. All rights reserved.
//

import Cocoa
import WebKit

class DocumentationViewController: NSViewController {

    private var webView: WKWebView = WKWebView.init()
    private var button = NSButton.init()
    private var documentListShowState: Bool = false
    private var backView = CustomControl.init()
    private var documentListViewController:DocumentListViewController?
    private lazy var onceCode: Void = {
         documentListViewController?.view.frame = NSRect.init(x: self.view.width, y: 0, width: 200, height: view.frame.height)
                backView.frame = CGRect.init(x: 0, y: 0, width: view.width, height: view.height)
    }()
}

extension DocumentationViewController {
    override func loadView() {
        self.view = NSView.init()
        installSubviews()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        installDocumentList()
        installBackView()
    }
    override func viewDidLayout() {
        super.viewDidLayout()
       _ = onceCode
    }
}


extension DocumentationViewController {
    private func installSubviews() {
        
        webView.navigationDelegate = self
        webView.uiDelegate = self
        view.addSubview(webView)

        button.target = self
        button.action = #selector(documentationAction)
        button.wantsLayer = true
        button.image = NSImage.init(named: NSImage.Name.init("docment_list_icon"))
        button.backgroundColor = NSColor.red
        button.setButtonType(.toggle)
        button.frame.size = NSSize.init(width: 45, height: 45)
        button.layer?.cornerRadius = 45 / 2
        button.layer?.masksToBounds = true
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(100)
            make.right.equalTo(view).offset(0)
        }
        
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(NSEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        }
    }

    private func installDocumentList() {
        let documentListVC = DocumentListViewController.init {[weak self] (model) in
                 if let url = URL.init(string: model.url) {
                     self?.webView.load(URLRequest.init(url: url))
                 }else {
                     // TODO: URL处理错误，请注意
                 }
             }
        self.addChild(documentListVC)
        view.addSubview(documentListVC.view)
        self.documentListViewController = documentListVC
    }
    private func installBackView() {
        self.backView.target = self
        backView.isHidden = true
        self.backView.action = #selector(documentationAction)
        backView.backgroundColor = NSColor.black
        backView.alphaValue = 0
        self.view.addSubview(backView, positioned: .below, relativeTo: documentListViewController?.view)
    }
}




extension DocumentationViewController : MainSubViewControllerProtocol {
    var type: MenuType {
        return .document
    }
}

extension DocumentationViewController : WKNavigationDelegate {
    // 页面开始加载时调用
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        debugPrint("begin")
    }
    // 当内容开始返回时调用
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        debugPrint("begining")
    }
    //页面加载完毕
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        debugPrint("end")
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        debugPrint("error:\(error.localizedDescription)")
    }
    // // 接收到服务器跳转请求之后调用
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {

    }
    // 在收到响应后，决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
         decisionHandler(.allow)
    }
}

extension DocumentationViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        return nil
    }
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {

    }
}

extension DocumentationViewController {
    @objc private func documentationAction() {
            // TODO:
        documentListShowState ? documentListHidden() : documentListShow()
        documentListShowState = !documentListShowState
    }
}

extension DocumentationViewController {
    private func documentListShow() {
        if let documentList = documentListViewController {
            button.isHidden = true
            backView.isHidden = false
            NSAnimationContext.runAnimationGroup({ (context) in
                context.duration = 0.3
                documentList.view.animator().setFrameOrigin(NSPoint.init(x: self.view.width - documentList.view.width, y: documentList.view.y))
                backView.animator().alphaValue = 0.3
            }) {
                // TODO:
            }
        }
    }
    private func documentListHidden() {
        if let documentList = documentListViewController {
            NSAnimationContext.runAnimationGroup({ (context) in
                context.duration = 0.3
                documentList.view.animator().setFrameOrigin(NSPoint.init(x:  self.view.width, y: 0))
                backView.animator().alphaValue = 0
            }) {
                self.button.isHidden = false
                self.backView.isHidden = true
            }
        }
    }
}
