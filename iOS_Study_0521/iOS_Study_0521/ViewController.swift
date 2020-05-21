//
//  ViewController.swift
//  iOS_Study_0521
//
//  Created by 최인정 on 2020/05/21.
//  Copyright © 2020 indoni. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var txtUrl: UITextField!
    @IBOutlet weak var myWebView: WKWebView!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        myWebView.navigationDelegate = self
        loadWebPage("https://github.com/inddoni")
        
    }
    
    //did commit 로딩 중 일때
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        myActivityIndicator.startAnimating()
        myActivityIndicator.isHidden = false
    }
    
    //did finish 로딩 다 된것 (정상적으로)
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }
    
    //did Fail 오류
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        myActivityIndicator.stopAnimating()
        myActivityIndicator.isHidden = true
    }
    
    func loadWebPage(_ url: String){
        let myUrl = URL(string: url)
        let myRequest = URLRequest(url: myUrl!)
        myWebView.load(myRequest)
    }
    
    func checkUrl(_ url: String)->String{
        var strUrl = url
        let flag = strUrl.hasPrefix("http://")
        if !flag{
            strUrl = "http://" + strUrl
        }
        return strUrl
    }

    @IBAction func btnGotoUrl(_ sender: Any) {
        let myUrl = checkUrl(txtUrl.text!)
        txtUrl.text = ""
        loadWebPage(myUrl)
    }
    
    @IBAction func btnGotoSite1(_ sender: Any) {
        loadWebPage("http://www.google.com")
    }
    
    @IBAction func btnGotoSite2(_ sender: Any) {
        loadWebPage("http://www.naver.com")
    }
    
    @IBAction func btnLoadHtmlString(_ sender: Any) {
        let htmlString = "<h1> HTML String </h1><p> String 변수를 이용한 웹페이지 </p> <p><a href=\"http://2sam.net\">2sam</a>으로 이동</p>"
        myWebView.loadHTMLString(htmlString, baseURL: nil)
    }
    @IBAction func btnLoadHtmlFile(_ sender: Any) {
        
        let filepath = Bundle.main.path(forResource: "htmlView", ofType: "html")
        let myUrl = URL(fileURLWithPath: filepath!)
        let myRequest = URLRequest(url: myUrl)
        myWebView.load(myRequest)
        
    }
    
    
    
    @IBAction func btnStop(_ sender: Any) {
        myWebView.stopLoading()
    }
    @IBAction func btnFastForward(_ sender: Any) {
        myWebView.goForward()
    }
    @IBAction func btnRewind(_ sender: Any) {
        myWebView.goBack()
    }
    @IBAction func btnRefresh(_ sender: Any) {
        myWebView.reload()
    }
    
}

