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
        let configuration = WKWebViewConfiguration()
        
        // 2. JavaScript 실행 활성화 (기본값이 true지만 명시적 설정)
        configuration.preferences.javaScriptEnabled = true
        
        // 3. (옵션) 모달(Alert) 창 띄우기 허용
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = true

        // 4. 설정이 적용된 웹뷰 반환
        let webView = WKWebView(frame: .zero, configuration: configuration)
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
