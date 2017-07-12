//
//  HeaderInfoViewController.swift
//  MyPlayer
//
//  Created by ybon on 2016/11/14.
//  Copyright © 2016年 zxh. All rights reserved.
//

import UIKit
import WebKit
class HeaderInfoViewController: UIViewController ,WKUIDelegate,WKNavigationDelegate{
    var url:String?;
    var infoWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        infoWebView = WKWebView.init();
        infoWebView.frame = CGRect.init(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight);
        infoWebView.scrollView.bounces = false;
        self.view.addSubview(infoWebView);

        let request = URLRequest.init(url: URL.init(string: url!)!);
//        infoWebView.navigationDelegate = self;
//        infoWebView.uiDelegate = self;
        infoWebView.load(request);
        
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated);
        //找到所有的cookies
        let storage = HTTPCookieStorage.shared;
        
        for cookie in storage.cookies! {
            //清除cookies
            storage.deleteCookie(cookie);
        }
        //清除webview中的缓存
        URLCache.shared.removeAllCachedResponses();
        infoWebView.removeFromSuperview();
        infoWebView = nil;
        
    }
  
    
}
