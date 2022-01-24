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
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTab))
        
        let url = URL(string: "https://www.apple.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    @objc func openTab(){
        let ac = UIAlertController(title: "Open Page", message: nil, preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "github.com", style: .default, handler: openPage))
        ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
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

}

