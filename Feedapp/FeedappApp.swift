//
//  FeedappApp.swift
//  Feedapp
//
//  Created by Gagandeep on 09/05/22.
//

import SwiftUI
import AttributedText

@main
struct FeedappApp: App {
    init() {
           AttributedText.tags = [
               "strong": { $0.bold() },
               "i": { $0.italic() }
           ]
       }
    
    var body: some Scene {
        let login = PostViewModel()
        WindowGroup {
            ContentView().environmentObject(login)
        }
    }
}
