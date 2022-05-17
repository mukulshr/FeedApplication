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
    VStack(alignment: .leading,spacing: 3) {
        Text("UserName".uppercased())
            .font(Font.Nunito.bold(size: 16))
            .foregroundColor(Color.textBlack)
            Text("SBI FOUNDATION".uppercased())
                .font(Font.Nunito.bold(size: 12))
                .foregroundColor(Color.customGrey)
                .padding(.bottom, 15)
       
        HStack{
            VStack{
                Text(dash.stories.uppercased())
                .font(Font.Nunito.bold(size: 24))
                .foregroundColor(Color.blue)
                Text("STORIES")
                    .font(Font.Nunito.bold(size: 14))
                    .foregroundColor(Color.blue)
            }
            Spacer()
            VStack{
                Text(dash.events.uppercased())
                .font(Font.Nunito.bold(size: 24))
                .foregroundColor(Color.blue)
                Text("CREATED")
                    .font(Font.Nunito.bold(size: 14))
                    .foregroundColor(Color.blue)
            }
            Spacer()
            VStack{
                Text(dash.sponsored.uppercased())
                .font(Font.Nunito.bold(size: 24))
                .foregroundColor(Color.blue)
                Text("SPONSORED")
                    .font(Font.Nunito.bold(size: 14))
                    .foregroundColor(Color.blue)
            }
        }
    }.onAppear {
        dashboardapiCall().getdashboard{ (aaa) in
            self.dash = aaa
        }
    }
    .padding(.vertical, 15)
    .padding(.leading, 35)
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
