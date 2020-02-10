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

    private let webView: WKWebView = WKWebView.init()
    private let listImageView = NSImageView.init()
    private var documentListShowState: Bool = false
    private let  backView = CustomControl.init()
    private var documentListViewController:DocumentListViewController?
    private lazy var onceCode: Void = {
         documentListViewController?.view.frame = NSRect.init(x: self.view.width, y: 0, width: 200, height: view.frame.height)
                backView.frame = CGRect.init(x: 0, y: 0, width: view.width, height: view.height)
    }()
    
    private let previousButton: NSImageView = NSImageView.init()
    private let nextButton: NSImageView = NSImageView.init()
    private let progressView = NSProgressView.init()
    
    deinit {
           self.webView.removeObserver(self, forKeyPath: "estimatedProgress")
           self.webView.uiDelegate = nil
           self.webView.navigationDelegate = nil
       }
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
        if let url = URL.init(string: "https://developer.apple.com/documentation") {
            self.webView.load(URLRequest.init(url:url))
        }
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
        webView.addObserver(self, forKeyPath:"estimatedProgress", options: NSKeyValueObservingOptions.new, context: nil)
        view.addSubview(webView)

        
        listImageView.addTarget(self, action: #selector(documentationAction))
        listImageView.isUserInteractionEnabled = true
        listImageView.wantsLayer = true
        listImageView.layer?.cornerRadius = 40 / 2
        listImageView.layer?.masksToBounds = true
        listImageView.backgroundColor = NSColor.red
        
        view.addSubview(listImageView)
        listImageView.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(100)
            make.right.equalTo(view).offset(0)
            make.size.equalTo(NSSize.init(width: 40, height: 40))
        }
        
        webView.snp.makeConstraints { (make) in
            make.edges.equalTo(NSEdgeInsets.init(top: 5, left: 0, bottom: 0, right: 0))
        }
        
        
        nextButton.image = NSImage.init(named: NSImage.Name.init("document_next_icon"))
        nextButton.sizeToFit()
        previousButton.image = NSImage.init(named: NSImage.Name.init("document_previous_icon"))
        previousButton.sizeToFit()
        nextButton.isUserInteractionEnabled = true
        previousButton.isUserInteractionEnabled = true
        nextButton.addTarget(self, action: #selector(nextButtonAction))
        previousButton.addTarget(self, action: #selector(previousButtonAction))
        view.addSubview(previousButton)
        view.addSubview(nextButton)
        
        previousButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(view)
            make.left.equalTo(view.snp.left).offset(15)
        }
        nextButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(view)
            make.right.equalTo(view.snp.right).offset(-15)
        }
        
        self.progressView.style = .default
        self.progressView.progressTinColor = NSColor.blue
        self.progressView.backgroundColor = NSColor.white
        self.progressView.alphaValue = 0
        self.progressView.setProgress(0, animated: true)
        self.view.addSubview(progressView)
        
        progressView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(view)
            make.height.equalTo(5)
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


extension DocumentationViewController {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.alphaValue = 1.0
            progressView.setProgress(Float(self.webView.estimatedProgress), animated: true)
           if self.webView.estimatedProgress >= 1.0 {
            NSAnimationContext.runAnimationGroup({ (context) in
                context.duration = 0.3
                self.progressView.alphaValue = 0
            }) {
                self.progressView.setProgress(0.0, animated: false)
            }
           }
            
        }else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
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
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }
}




extension DocumentationViewController {
    @objc private func documentationAction() {
            // TODO:
        documentListShowState ? documentListHidden() : documentListShow()
        documentListShowState = !documentListShowState
    }
    
    @objc private func nextButtonAction() {
        debugPrint("\(#function)")
    }
    @objc private func previousButtonAction() {
        debugPrint("\(#function)")
    }
}

extension DocumentationViewController {
    private func documentListShow() {
        if let documentList = documentListViewController {
            listImageView.isHidden = true
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
                self.listImageView.isHidden = false
                self.backView.isHidden = true
            }
        }
    }
}
