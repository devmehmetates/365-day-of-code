//
//  ViewController.swift
//  Day24-26
//
//  Created by Mehmet Ateş on 24.01.2022.
//

import UIKit
import WebKit

class ViewController: UIViewController , WKNavigationDelegate{
    
    var webView : WKWebView!
    var progressView : UIProgressView!
    let webSites = ["apple.com", "github.com"]
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTab))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let reflesh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        toolbarItems = [progressButton, spacer, reflesh]
        navigationController?.isToolbarHidden = false
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        let url = URL(string: "https://" + webSites[0])!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    @objc func openTab(){
        let ac = UIAlertController(title: "Open Page", message: nil, preferredStyle: .actionSheet)
        
        for webSite in webSites {
            ac.addAction(UIAlertAction(title: webSite, style: .default, handler: openPage))
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(ac,animated: true)
    }

    func openPage(action : UIAlertAction! = nil){
        guard let actionTitle = action.title else {return}
        guard let url = URL(string: "https://" + actionTitle) else{return}
        webView.load(URLRequest(url: url))
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host{
            for webSite in webSites {
                if host.contains(webSite){
                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.cancel)
    }

}

