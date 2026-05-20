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
    
    func openURI(_ scheme: String) -> URL? {
        switch scheme {
        case "bccard://":
            return URL(string: "https://go.bccard.com/")
        case "kbpay-kbkookmincard://":
            return URL(string: "https://m.kbcard.com/BON/DVIEW/MBHV1103")
        case "shc-ansimclick://":
            return URL(string: "https://www.shinhancard.com/pconts/html/myPage/governmentSupport/MOBFM591N/MOBFM591R03.html")
        case "cloudpay://":
            return URL(string: "https://m.hanacard.co.kr/MKGAAV9320M.web")
        case "com.wooricard.wcard://":
            return URL(string: "https://m.wooricard.com/dcmw/yh1/mcd/mcd04/fcstistlfee/M1MCD204S70.do")
        case "nhallonepayansimclick://":
            return URL(string: "https://www.nhcard.com")
        case "monimopay://":
            return URL(string: "https://www.samsungcard.com")
        case "hdcardappcardansimclick://":
            return URL(string: "https://www.hyundaicard.com")
        default:
            break
        }
        return nil
    }
    
    // 1. 웹 탐색(이동) 시작을 허용할지 결정
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        
        guard let url = navigationAction.request.url else {
            decisionHandler(.allow)
            return
        }
        
        if let scheme = url.scheme {
            if scheme == "tel" || scheme == "sms" || scheme == "mailto" || scheme == "items" || scheme == "https" {
                UIApplication.shared.openURI(url)
                decisionHandler(.cancel)
                return
            }
        }

        if let urlScheme = navigationAction.request.url?.absoluteString, !urlScheme.isEmpty {
            if urlScheme == "bccard://" || urlScheme == "kbpay-kbkookmincard://" || urlScheme == "shc-ansimclick://" || urlScheme == "cloudpay://" || urlScheme == "com.wooricard.wcard://" || urlScheme == "nhallonepayansimclick://" || urlScheme == "monimopay://" || urlScheme == "hdcardappcardansimclick://" {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:]) { success in

                    }
                } else {
                    if let url = self.openURI(urlScheme) {
                        UIApplication.shared.openURI(url)
                        decisionHandler(.cancel)
                        return
                    }
                }
                decisionHandler(.cancel)
                return
            }
        }
        
        if navigationAction.targetFrame?.isMainFrame == false {
            decisionHandler(.allow)
            return
        }
        
        // OAuth 관련 URL 허용 (예: accounts.google.com, appleid.apple.com 등)
        if let url = navigationAction.request.url?.absoluteString {
            let allowedHosts = ["appleid.apple.com", "accounts.google.com"]
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
