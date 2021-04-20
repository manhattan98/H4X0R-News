//
//  DetailView.swift
//  H4X0R News
//
//  Created by Eremej Sumcenko on 03.03.2021.
//

import SwiftUI
import WebKit

struct DetailView: View {
    let urlString: String?
    
    var body: some View {
        if let safeUrlString = urlString {
            WebView(url: URL(string: safeUrlString)!)
        }
        else {
            Text("no url presented")
        }
    }
}

struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        
        uiView.load(request)
    }
    
    let url: URL
    

}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(urlString: "https://www.google.com")
    }
}
