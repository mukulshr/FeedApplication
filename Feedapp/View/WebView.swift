
import SwiftUI
import WebKit

struct Webview: UIViewRepresentable {
    @State private var AuthToken = UserDefaults.standard.string(forKey: "Token")
    
    let url: URL?
    
    func makeUIView(context: Context) -> WKWebView{
        
        var prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        return WKWebView(frame: .zero, configuration: config)
    
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let myURL = url else {
            return
        }
        
        let headers = [
                    "Authorization": "eyJpdiI6ImR3MmNWOVAxd2NKV0NVaWV3QXp2eUE9PSIsInZhbHVlIjoibnZLR2k3anpRcUNaTlpxK0VTT1RzUT09IiwibWFjIjoiNWU4MTU1Y2ZjMWJiNTgzY2ZkMzdjNjc0MmYyYWRjNTk0ZWFhNDdkNWFlODYxOTU3YjI4YjZhZjAzZmQwZThlOCJ9",
                   
                ]
        
        var request = URLRequest(url: myURL)
        request.allHTTPHeaderFields = headers
        request.addValue(AuthToken!, forHTTPHeaderField: "Authorization")
        request.addValue("https://www.mysuperhumanrace-uat.com/", forHTTPHeaderField: "ServerURL")
        print(request)
        uiView.load(request)
    }
    
    
    
}
