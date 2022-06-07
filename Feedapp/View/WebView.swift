
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
        var request = URLRequest(url: myURL)
        request.addValue(AuthToken!, forHTTPHeaderField: "Authorization")

    print(request)
    uiView.load(request)

            
    }
    
    
    
}
