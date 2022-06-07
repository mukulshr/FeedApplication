//
//  profileheader.swift
//  Clubhouse
//
//  Created by Gagandeep on 26/04/22.
//

import SwiftUI

struct profileheader: View{

    @State var dash = reqdash(stories: "0", events: "0", sponsored: "0")
    
var body: some View {
    VStack(alignment: .leading,spacing: 5) {
        Text("UserName".uppercased())
            .font(Font.Muli.muli(size: 16))
            .foregroundColor(Color.textBlack)
            Text("SBI FOUNDATION".uppercased())
            .font(Font.Muli.muli(size: 12))
                .foregroundColor(Color.textBlack)
                .padding(.bottom, 15)
       
        HStack{
            VStack(spacing: 5){
                Text(dash.stories.uppercased())
                    .font(Font.Muli.muli(size: 24))
                .foregroundColor(Color.blue)
                Text("STORIES")
                    .font(Font.Muli.muli(size: 14))
                    .foregroundColor(Color.blue)
            }
            Spacer()
            VStack(spacing: 5){
                Text(dash.events.uppercased())
                    .font(Font.Muli.muli(size: 24))
                .foregroundColor(Color.blue)
                Text("CREATED")
                    .font(Font.Muli.muli(size: 14))
                    .foregroundColor(Color.blue)
            }
            Spacer()
            VStack(spacing: 5){
                Text(dash.sponsored.uppercased())
                    .font(Font.Muli.muli(size: 24))
                .foregroundColor(Color.blue)
                Text("SPONSORED")
                    .font(Font.Muli.muli(size: 14))
                    .foregroundColor(Color.blue)
            }
        }
    }.onAppear {
        dashboardapiCall().getdashboard{ (aaa) in
            self.dash = aaa
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
struct profileheader_Previews: PreviewProvider {
    static var previews: some View {
        profileheader()
            .previewLayout(.sizeThatFits)
    }
}
