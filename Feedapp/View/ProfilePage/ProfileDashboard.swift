//
//  ProfileDashboard.swift
//  Feedapp
//
//  Created by Gagandeep on 13/06/22.
//

import SwiftUI

struct ProfileDashboard: View{
    @State var UserName : String = ""

    @State var profiledash = profiledashdata(stories: "0", events: "0", sponsored: "0",activeUserEmployerName:"-")
    
var body: some View {
    VStack(alignment: .leading,spacing: 5) {
        Text(UserName)
            .font(Font.Muli.muli(size: 16))
            .foregroundColor(Color.textBlack)
        Text(profiledash.activeUserEmployerName)
            .font(Font.Muli.muli(size: 12))
                .foregroundColor(Color.textBlack)
                .padding(.bottom, 15)
       
        HStack{
            VStack(spacing: 5){
                Text(profiledash.stories.uppercased())
                    .font(Font.Muli.muli(size: 24))
                .foregroundColor(Color.blue)
                Text("STORIES")
                    .font(Font.Muli.muli(size: 14))
                    .foregroundColor(Color.blue)
            }
            Spacer()
            VStack(spacing: 5){
                Text(profiledash.events.uppercased())
                    .font(Font.Muli.muli(size: 24))
                .foregroundColor(Color.blue)
                Text("CREATED")
                    .font(Font.Muli.muli(size: 14))
                    .foregroundColor(Color.blue)
            }
            Spacer()
            VStack(spacing: 5){
                Text(profiledash.sponsored.uppercased())
                    .font(Font.Muli.muli(size: 24))
                .foregroundColor(Color.blue)
                Text("SPONSORED")
                    .font(Font.Muli.muli(size: 14))
                    .foregroundColor(Color.blue)
            }
        }
    }.onAppear {
        profiledashboardapiCall().getprofiledashboard{ (aaa) in
            self.profiledash = aaa
        }
    }
    .padding(.vertical, 15)
    .padding(.leading, 15)
    .padding(.trailing, 15)
    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
           alignment: .leading)
    .background(Color.white)
    .padding(.horizontal, 15)
}
}
struct ProfileDashboard_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDashboard()
            .previewLayout(.sizeThatFits)
    }
}
