//
//  ViewController.swift
//  EasyBrowser
//
//  Created by javan.chen on 2015/10/20.
//  Copyright © 2015年 Javan chen. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    var webView: WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com", "hackingwithswift.com"]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Open Button
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .Plain, target: self, action: "openTapped")
        //ToolBar refresh Button
        let spacer = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .Refresh, target: webView, action: "reload")
        //ToolBar ProgressView
        progressView = UIProgressView(progressViewStyle: .Default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .New, context: nil)
        //ToolBar
        toolbarItems = [progressButton, spacer, refresh]
        navigationController?.toolbarHidden = false
        //open app first http
        let url = NSURL(string: "https://" + websites[0])!
        webView.loadRequest(NSURLRequest(URL: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    func openTapped() {
        let ac = UIAlertController(title: "Open page...", message: nil, preferredStyle: .ActionSheet)
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .Default, handler: openPage))
        }
        presentViewController(ac, animated: true, completion: nil)
    }
    
    func openPage(action: UIAlertAction!) {
        let url = NSURL(string: "https://" + action.title!)!
        webView.loadRequest(NSURLRequest(URL: url))
    }
    
    func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        title = webView.title
    }
    
    func webView(webView: WKWebView, decidePolicyForNavigationAction navigationAction: WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.URL
        if let host = url!.host {
            for website in websites {
                if host.rangeOfString(website) != nil {
                    decisionHandler(.Allow)
                    return
                }
            }
        }
        decisionHandler(.Cancel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
}

