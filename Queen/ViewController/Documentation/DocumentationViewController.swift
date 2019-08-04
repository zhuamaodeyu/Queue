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

    private var webView: WKWebView!

    override func loadView() {
        self.view = NSView.init()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
        self.view.backgroundColor = NSColor.red

        installSubviews()

        webView.load(URLRequest.init(url: URL.init(string: "https://medium.com/@jerrywang0420/codable-json-%E6%95%99%E5%AD%B8-swift-4-46aff2182bfe")!))
    }
}

extension DocumentationViewController {
    private func installSubviews() {
        webView = WKWebView.init()
        webView.navigationDelegate = self
        webView.uiDelegate = self
        view.addSubview(webView)

        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(NSEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0))
        }
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
