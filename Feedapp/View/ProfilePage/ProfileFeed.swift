//
//  ProfileFeed.swift
//  Feedapp
//
//  Created by Gagandeep on 13/06/22.
//
import SwiftUI
import SDWebImageSwiftUI
import WebKit
import RichText


struct ProfileFeed: View {
    
    //    let room: FeedRoom
        private let size: CGFloat = 50
        @State private var showsBottomSheet: Bool = false
        @State var req: [reqdata] = []
        @State var IsLoading: Bool = true
        @State var filteredcity: String = ""
        @State var filteredcityid: Int = 0
        @State var UserId : Int = 0
        @State var reqprofileid: String = ""
    var emptyempid: String = ""
        
        
        func activityid(id: Int,posttype: String) -> Int {
            if (posttype == "0") {
                   return 0;
               } else {
                   return id;
               }

        }
        
        
        func showdesc(descrip: String,storydesc: String) -> String {
            if descrip != "" {
                   return descrip;
               } else {
                   return storydesc;
               }

        }
        
        func shareit(sharelink: String) {
               guard let urlShare = URL(string: "https://www.mysuperhumanrace-uat.com/\(sharelink)") else { return }
               let activityVC = UIActivityViewController(activityItems: [urlShare], applicationActivities: nil)
               UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
           }
        


        
        var body: some View {
            
            
            ZStack{
            
            VStack(alignment: .leading) {
                
                
                if (filteredcity != ""){
                
                Text(filteredcity)
                    .font(.custom("muli", size: 15))
                        .foregroundColor(Color.black)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    
                    .onTapGesture{
                        DispatchQueue.main.async {
                        self.IsLoading = true
                        apiCall().getUsers(lastid: 0, cityid: 0,profileid: reqprofileid,empid: emptyempid) { (users) in
                            self.req = users
                            filteredcity = ""
                            filteredcityid = 0
                            self.IsLoading = false
                //            print(req)
                        }
                        }
                    }
                }
                
               
                    LazyVStack(spacing: 10){
                ForEach(req, id: \.id) { user in
                
                
                       
    //            Text(room.roomName)
    //                .font(Font.Nunito.bold(size: 16))
    //                .foregroundColor(Color.textBlack)
    //
                    LazyVStack(alignment: .leading, spacing: 10) {
                    if let groupName = user.feed_type_name {
                        HStack() {
                            Image(uiImage: UIImage(named: "location-thin")!)
                                    .resizable()
                                .foregroundColor(Color.black)
                            .frame(width: 20, height: 25, alignment: .leading)
                            
                            VStack(alignment: .leading){
                                Text("\(user.cityName),\(user.stateName)")
                                    .font(Font.Muli.muli(size: 16))
                                    .onTapGesture{
                                        
                                        apiCall().getUsers(lastid: 0, cityid: user.city,profileid: reqprofileid,empid: emptyempid) { (users) in
                                            self.IsLoading = true
                                            if users == [] {
                                                print("its empty")
                                                filteredcity = "\(user.cityName),\(user.stateName)"
                                            }else{
                                            self.req = users
                                            
                                                filteredcity = "\(user.cityName),\(user.stateName)"
                                            filteredcityid = user.city
                                            print(user.cityName,user.city,users)
                                            }
                                            
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            self.IsLoading = false
                                            }
                                        }
                                       
                                        }
                                       

                                .foregroundColor(Color.black)
                                Text(user.feedDate)
                                    .font(Font.Muli.muli(size: 12))

                                    .foregroundColor(Color.darkGrey)
                            }
                            
                            Spacer()
                            if user.feed_icon_type.count > 0{
                            Image(uiImage: UIImage(named: setIcons(iconCount: user.feed_icon_count, iconType: user.feed_icon_type ))!)
                                    .resizable()
                                .foregroundColor(Color.black)
                            .frame(width: 30, height: 35, alignment: .trailing)
                          
                            }
                            
                           
                        }                    .padding(.horizontal, 15)
                    }
                    
                        
                        
                      
                    HStack(){
                       AnimatedImage(url: URL(string: user.feedUserPic))
                            .resizable()
                            .frame(width: 30, height: 30)
                            .cornerRadius(25)
                        Text(user.feedUserName)
                            .foregroundColor(Color.black)
                        .padding(.trailing, 5)
                        .font(.custom("muli", size: 18))

                    }.padding(.horizontal, 15)
                            .onTapGesture{
                                let str = "\(UserId)"
//                                let utf8str = str.data(using: .utf8)
//                                 let base64Encoded = utf8str?.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
//                                reqprofileid = base64Encoded
                                print("\(UserId)".data(using: .utf8)!.base64EncodedString())
                            }
                        
                        
                        
                        
                        
                        if user.post_type == "0"{
                            if user.feedUserType == "1"{
                              
                                HalfLayouttype(desc:  showdesc(descrip: user.description, storydesc: user.storyDescription), img: user.story_img)
                            }else{
                                Fulllayouttype(desc:  showdesc(descrip: user.description, storydesc: user.storyDescription), img: user.story_img)
                            }
                        }else if (user.post_type == "1" && user.feedType == 18){
                            if user.feedUserType == "1"{
                                HalfLayouttype(desc:  showdesc(descrip: user.description, storydesc: user.storyDescription), img: user.story_img)
                            }else{
                                Fulllayouttype(desc:  showdesc(descrip: user.description, storydesc: user.storyDescription), img: user.story_img)
                            }
                        }else{
                            Nonlayouttype(desc:  showdesc(descrip: user.description, storydesc: user.storyDescription))
                        }
                        
                     
                        
                        
                        
                        
                       
                        
    //                    VStack{
    //                        RichText(html: "attempted a quiz - <strong>Save Energy this Summer! </strong> on <strong>06 May 2022</strong> at <strong>06:29 PM</strong>")
    //                            .font(.custom("muli", size: 18))
    //                            .foregroundColor(Color.darkGrey)
    //                    }
                        
                  
                        LazyVStack(alignment:.leading ,spacing:0){
                        Text(user.category_name)
                                .foregroundColor(.white)
                                .font(Font.Muli.muli(size: 13))
                                .padding(.leading, 15)
                                .lineLimit(1)
                            Text(user.name)
                                .foregroundColor(.white)
                                .font(Font.Muli.muli(size: 18))
                                .padding(.leading, 15)
                                .lineLimit(1)
                        } .frame( height: 55)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                            .background(Rectangle().fill( LinearGradient(gradient: Gradient(colors: [.gradientdark, .gradientlight]), startPoint: .leading, endPoint: .trailing)
                                                        ))
                        
                            
                    
                    
                    HStack() {
                        
                        Button(action: {
                           
                            if user.userLike == "0"{
                               
                               
                                
                                
                                    DispatchQueue.main.async{
                                        like(needpostid: user.postId,needId: activityid(id: user.id,posttype: user.post_type))
                                        if let index = self.req.index(where: {$0.id == user.id}){
                                        self.req[index].userLike = "1"
                                            self.req[index].totalLikes += 1
                                        print(self.req[index])
                                        }
                                    }
                                    
                                
                               
                            }else if user.userLike == "1"{
                                DispatchQueue.main.async{
                                dislike(needpostid: user.postId,needId: activityid(id: user.id,posttype: user.post_type))
                                if let index = self.req.index(where: {$0.id == user.id}){
                                self.req[index].userLike = "0"
                                    self.req[index].totalLikes -= 1
                                print(self.req[index])
                                }
                                }
                                
                            }
                           
                        }, label: {
                            Text("Likes (\(user.totalLikes))")
                                .font(Font.Muli.muli(size: 14))
                                .foregroundColor(Color.black)
                            
                            
                            if user.userLike == "0"{
                            Image(uiImage: UIImage(named: "heart-thin")!)
                                    .resizable()
                                    .foregroundColor(Color.black)
                                .frame(width: 20, height: 20, alignment: .leading)
                            }else if user.userLike == "1"{
                            
                            Image(uiImage: UIImage(named: "heart-solid")!)
                                    .resizable()
                                    .foregroundColor(Color.red)
                                .frame(width: 20, height: 20, alignment: .leading)
                            }
                            
                            

                        })
                        

                        Spacer()
                        
                        NavigationLink(destination: CommentView(need : user.category_name,needpostid: user.postId,needId: activityid(id: user.id,posttype: user.post_type))) {
                            Text("Comment")
                                .font(.custom("muli", size: 14))
                                .foregroundColor(Color.black)
                            Image(uiImage: UIImage(named: "message-thin")!)
                                    .resizable()
                                    .foregroundColor(Color.black)
                                .frame(width: 20, height: 20, alignment: .leading)
                        
                        }
//                        .navigationBarTitle(Text(user.name))

                        Spacer()
                        Button(action: {shareit(sharelink: user.read_more_link)}, label: {
                            Text("Share")
                                .font(Font.Muli.muli(size: 14))
                                .foregroundColor(Color.black)
                            Image(uiImage: UIImage(named: "share-icon")!)
                                    .resizable()
                                    .foregroundColor(Color.black)
                                .frame(width: 20, height: 20, alignment: .leading)
                            
                        })
                        
                        
                       
                        
                    }.onAppear{
                       
                        print(user.id)
                        
                        if user.id == req.last?.id {
                            print("this is last",user.id)
                            self.IsLoading = true
                  
                            apiCall().getUsers(lastid: user.id, cityid: filteredcityid,profileid: reqprofileid,empid: emptyempid) { (users) in
                                self.req.append(contentsOf: users)
                                self.IsLoading = false
                            }
                            
                            
                        }
                        
                    }
                    
                    
                    .padding(.horizontal, 15)
    //                .padding(.top, 10)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                           maxHeight: 60,
                           alignment: .top)
                    
                }
                    
                

                    
                   
                }
                        
            .padding(.vertical, 5)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
            .background(Color.cardBackground)
            .padding(.horizontal, 5)
                    }
                
                
                
            
        }.onAppear {
            
            apiCall().getUsers(lastid: 0, cityid: filteredcityid,profileid: reqprofileid,empid: emptyempid) { (users) in
                self.req = users
                self.IsLoading = false
            }
           
        }
            
            
            if (req.isEmpty || IsLoading){
                ActivityIndicator()
                    .frame(alignment: .center)
                    .zIndex(1)
                
            }
        }
        }
    }

struct ProfileFeed_Previews: PreviewProvider {
    static var previews: some View {
        ProfileFeed()
    }
}
