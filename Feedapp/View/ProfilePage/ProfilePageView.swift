//
//  ProfilePageView.swift
//  Feedapp
//
//  Created by Gagandeep on 13/06/22.
//

import SwiftUI

struct ProfilePageView: View {
    @State var username : String = ""
    @State var userid : Int = 0
    
    var body: some View {
//        NavigationView{
            ScrollView{
        ProfileDashboard(UserName: username)
                  
                ProfileFeed(UserId: userid,reqprofileid: "\(userid)".data(using: .utf8)!.base64EncodedString())
                
            }.frame(maxWidth: .infinity,
                    maxHeight: .infinity)
             .background(Color.background)
             
//             .navigationBarHidden(true)
         
            .navigationBarTitle(Text(username).font(.custom("muli", size: 18)), displayMode: .inline)
//            .navigationBarHidden(true)
//        }
    }
}

struct ProfilePageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePageView()
    }
}
