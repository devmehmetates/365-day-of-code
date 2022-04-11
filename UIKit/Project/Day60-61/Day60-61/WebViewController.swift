//
//  WebViewController.swift
//  Day60-61
//
//  Created by Mehmet Ateş on 2.03.2022.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate{
    var webView : WKWebView!
    var countryName: String = ""
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let url = URL(string: "https://tr.wikipedia.org/wiki/" + countryName)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
