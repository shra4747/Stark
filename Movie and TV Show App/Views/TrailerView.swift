//
//  TrailerView.swift
//  Movie and TV Show App
//
//  Created by Shravan Prasanth on 7/31/21.
//

import SwiftUI
import WebKit

struct TrailerView : UIViewRepresentable {
    
    let trailerYTLink: String
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: trailerYTLink) else {
            return
        }
        
        let request = URLRequest(url: url)
        
        uiView.load(request)
    }
    
}
