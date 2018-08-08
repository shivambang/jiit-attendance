//
//  Webkiosk.swift
//  TT
//
//  Created by Shivam Bang on 25/07/18.
//  Copyright © 2018 Bang. All rights reserved.
//

import UIKit
import WebKit
class Webkiosk: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "WebKiosk"
        let url = URL(string: "https://webkiosk.jiit.ac.in/")
        let myRequest = URLRequest(url: url!)
        self.webView.load(myRequest)
    }
    
    func update(){
        Login().login(){ (cookie, re) in
        let urlstr = "https://webkiosk.jiit.ac.in/StudentFiles/StudentPage.jsp"
        let url = URL(string: urlstr)
        let jar = HTTPCookieStorage.shared
        jar.setCookies(cookie, for: url, mainDocumentURL: nil)
        let myRequest = URLRequest(url: url!)
        self.loadView()
        self.webView.load(myRequest)
        }
    }
    
}
