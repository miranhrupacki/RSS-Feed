//
//  WebView.swift
//  RSSFeed
//
//  Created by Miran Hrupački on 25.09.2024..
//

import Foundation
import WebKit
import SwiftUI

struct WebView: UIViewRepresentable {
     var urlToLoad: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: urlToLoad) else { return }
        uiView.load(URLRequest(url: url))
    }
}
