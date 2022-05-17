//
//  VolunteerView.swift
//  Feedapp
//
//  Created by Gagandeep on 17/05/22.
//

import SwiftUI

struct VolunteerView: View {
    var body: some View {
        Webview(url: URL( string: "https://www.mysuperhumanrace-uat.com/volunteer"))
            .navigationTitle("Do Good Work")
    }
}

struct VolunteerView_Previews: PreviewProvider {
    static var previews: some View {
        VolunteerView()
    }
}
