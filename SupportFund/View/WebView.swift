//
//  WebView.swift
//  SupportFund
//
//  Created by 오션블루 on 5/18/26.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let fileName: String = "supportFund"
    
    // Coordinator 생성
    func makeCoordinator() -> WebViewCoordinator {
        WebViewCoordinator(self)
    }
    
    // UIKit 뷰 생성
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator // 델리게이트 연결
        return webView
    }
    
    // 뷰 업데이트
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "html")
        else {
            return
        }
        
        
        let fileURL = URL(fileURLWithPath: filePath)
        let folderURL = fileURL.deletingLastPathComponent()
        uiView.loadFileURL(fileURL, allowingReadAccessTo: folderURL)
    }
    
}
