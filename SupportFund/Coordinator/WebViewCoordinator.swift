//
//  WebViewCoordinator.swift
//  SupportFund
//
//  Created by 오션블루 on 5/19/26.
//

import SwiftUI
import WebKit

class WebViewCoordinator: NSObject, WKNavigationDelegate {
    var parent: WebView
    
    init(_ parent: WebView) {
        self.parent = parent
    }
    
    // 1. 웹 탐색(이동) 시작을 허용할지 결정
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        
        if navigationAction.targetFrame?.isMainFrame == false {
            decisionHandler(.allow)
            return
        }
        
        // OAuth 관련 URL 허용 (예: accounts.google.com, appleid.apple.com 등)
        if let url = navigationAction.request.url?.absoluteString {
            let allowedHosts = ["appleid.apple.com", "accounts.google.com", "your-sso-domain.com"]
            if allowedHosts.contains(where: { url.contains($0) }) {
                decisionHandler(.allow)
                return
            }
        }
        
        
        
        decisionHandler(.allow) // 또는 특정 조건에 따라 .cancel
    }
    
    // 2. 웹페이지 로딩이 시작될 때
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("로딩 시작...")
    }
    
    // 3. 웹페이지 로딩이 완료되었을 때
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("로딩 완료!")
    }
    
    // 4. 로딩 중 에러가 발생했을 때
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("에러 발생: \(error.localizedDescription)")
    }
}
