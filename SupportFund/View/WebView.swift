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
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
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
