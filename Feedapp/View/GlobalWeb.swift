//
//  VolunteerView.swift
//  Feedapp
//
//  Created by Gagandeep on 17/05/22.
//

import SwiftUI

struct GlobalView: View {
    @State var endpoint: String = ""
    
    var body: some View {
        Webview(url: URL( string: "https://www.mysuperhumanrace-uat.com/\(endpoint)"))
            .navigationTitle("Do Good Work")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct GlobalView_Previews: PreviewProvider {
    static var previews: some View {
        GlobalView()
    }
}
