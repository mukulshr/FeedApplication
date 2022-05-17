//
//  FeedappApp.swift
//  Feedapp
//
//  Created by Gagandeep on 09/05/22.
//

import SwiftUI

@main
struct FeedappApp: App {
    var body: some Scene {
        let login = PostViewModel()
        WindowGroup {
            ContentView().environmentObject(login)
        }
    }
}
