
import SwiftUI
import SDWebImageSwiftUI
import WebKit
import RichText


struct FeedRoomView: View {
    
//    let room: FeedRoom
    private let size: CGFloat = 50
    @State private var showsBottomSheet: Bool = false
    @State var req: [reqdata] = []
    @State var IsLoading: Bool = true
    
    
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
            
            
            
            
           
                LazyVStack(spacing: 20){
            ForEach(req, id: \.id) { user in
            
            
                   
//            Text(room.roomName)
//                .font(Font.Nunito.bold(size: 16))
//                .foregroundColor(Color.textBlack)
//
                LazyVStack(alignment: .leading, spacing: 10) {
                if let groupName = user.feed_type_name {
                    HStack(spacing: 10) {
                        Image(uiImage: UIImage(named: "location-thin")!)
                                .resizable()
                            .foregroundColor(Color.black)
                        .frame(width: 20, height: 25, alignment: .leading)
                        VStack(alignment: .leading){
                            Text(user.cityName)
                                .font(Font.Muli.muli(size: 14))

                            .foregroundColor(Color.black)
                            Text(user.feedDate)
                                .font(Font.Muli.muli(size: 10))

                                .foregroundColor(Color.darkGrey)
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
                    
//                    self.desc = showde
//                    self.img =  user.story_img
//
                    
                    
                
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
                    
              
                VStack(alignment:.leading){
                    Text(user.category_name)
                            .foregroundColor(.white)
                            .font(Font.Muli.muli(size: 13))
                            .padding(.leading, 20)
                        Text(user.name)
                            .foregroundColor(.white)
                            .font(Font.Muli.muli(size: 18))
                            .padding(.leading, 20)
                    } .frame( height: UIScreen.screenHeight * 0.08)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .background(Rectangle().fill( LinearGradient(gradient: Gradient(colors: [.gradientdark, .gradientlight]), startPoint: .leading, endPoint: .trailing)
                                                    ))
                    
                        
                
                
                HStack() {
                    
                    Button(action: {
                       
                        if user.userLike == "0"{
                            like(needpostid: user.postId,needId: activityid(id: user.id,posttype: user.post_type))
                        
                        }else if user.userLike == "1"{
                            dislike(needpostid: user.postId,needId: activityid(id: user.id,posttype: user.post_type))
                        
                        }
                       
                    }, label: {
                        Text("Likes (\(user.totalLikes))")
                            .font(Font.Muli.muli(size: 16))
                            .foregroundColor(Color.black)
                        
                        
                        if user.userLike == "0"{
                        Image(uiImage: UIImage(named: "heart-thin")!)
                                .resizable()
                                .foregroundColor(Color.black)
                            .frame(width: 25, height: 25, alignment: .leading)
                        }else if user.userLike == "1"{
                        
                        Image(uiImage: UIImage(named: "heart-solid")!)
                                .resizable()
                                .foregroundColor(Color.red)
                            .frame(width: 25, height: 25, alignment: .leading)
                        }
                        
                        

                    })
                    

                    Spacer()
                    
                    NavigationLink(destination: CommentView(need : user.category_name,needpostid: user.postId,needId: activityid(id: user.id,posttype: user.post_type))) {
                        Text("Comment")
                            .font(.custom("muli", size: 16))
                            .foregroundColor(Color.black)
                        Image(uiImage: UIImage(named: "message-thin")!)
                                .resizable()
                                .foregroundColor(Color.black)
                            .frame(width: 25, height: 25, alignment: .leading)
                    
                    }.navigationBarTitle(Text(user.name))

                    Spacer()
                    Button(action: {shareit(sharelink: user.read_more_link)}, label: {
                        Text("Share")
                            .font(Font.Muli.muli(size: 16))
                            .foregroundColor(Color.black)
                        Image(uiImage: UIImage(named: "share-icon")!)
                                .resizable()
                                .foregroundColor(Color.black)
                            .frame(width: 25, height: 25, alignment: .leading)
                        
                    })
                    
                    
                   
                    
                }.onAppear{
                   
                    print(user.id)
                    
                    if user.id == req.last?.id {
                        print("this is last",user.id)
                        self.IsLoading = true
              
                        apiCall().getUsers(lastid: user.id) { (users) in
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
                    
        .padding(.vertical, 10)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
        .background(Color.cardBackground)
        .padding(.horizontal, 15)
                }
            
            
            
        
    }.onAppear {
        apiCall().getUsers(lastid: 0) { (users) in
            self.req = users
            self.IsLoading = false
//            print(req)
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



func lasts(){
    print("lasting")
}

func like(needpostid: Int,needId: Int) {
    let parameters = "{\r\n    \"action\": \"like\",\r\n    \"data\": {\r\n        \"interaction\": \"like\",\r\n        \"actionType\": \"create\",\r\n        \"postId\": \(needpostid),\r\n        \"activityId\": \(needId)\r\n    }\r\n}"
    let postData = parameters.data(using: .utf8)

    var request = URLRequest(url: URL(string: "https://www.mysuperhumanrace-uat.com/api/socialApis")!,timeoutInterval: Double.infinity)
    request.addValue("eyJpdiI6Iko3VUtOMzBtOUdzWHkrT01FMWtlMHc9PSIsInZhbHVlIjoickdrNWNidjlPTXpZVm1NdVVDNDM3dz09IiwibWFjIjoiNDg4ZjEwNjQ0NzM2NTcxNGFiNzc5NGJiYjk1Y2Q4MWM5YmE2M2MyNzI5ODdhMzRkOTEwYjUwMmM0YTQ4MzgzNCJ9", forHTTPHeaderField: "Authorization")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    request.httpMethod = "POST"
    request.httpBody = postData

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else {
        print("error")
        return
      }
      print("like succedd")
    }

    task.resume()

}



func dislike(needpostid: Int,needId: Int) {
    let parameters = "{\r\n    \"action\": \"like\",\r\n    \"data\": {\r\n        \"interaction\": \"like\",\r\n        \"actionType\": \"delete\",\r\n        \"postId\": \(needpostid),\r\n        \"activityId\": \(needId)\r\n    }\r\n}"
    let postData = parameters.data(using: .utf8)

    var request = URLRequest(url: URL(string: "https://www.mysuperhumanrace-uat.com/api/socialApis")!,timeoutInterval: Double.infinity)
    request.addValue("eyJpdiI6Iko3VUtOMzBtOUdzWHkrT01FMWtlMHc9PSIsInZhbHVlIjoickdrNWNidjlPTXpZVm1NdVVDNDM3dz09IiwibWFjIjoiNDg4ZjEwNjQ0NzM2NTcxNGFiNzc5NGJiYjk1Y2Q4MWM5YmE2M2MyNzI5ODdhMzRkOTEwYjUwMmM0YTQ4MzgzNCJ9", forHTTPHeaderField: "Authorization")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    request.httpMethod = "POST"
    request.httpBody = postData

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else {
        print("error")
        return
      }
      print("dislike succedd")
    }

    task.resume()

}


extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
   static let screenHeight = UIScreen.main.bounds.size.height
   static let screenSize = UIScreen.main.bounds.size
}

//struct FeedRoomView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedRoomView( )
////            .preferredColorScheme(.dark)
//    }
//}

struct HalfLayouttype: View {
    @State var desc: String = ""
    @State var img: String = ""
    


    var body: some View {
        
                    HStack(){

                        Text(desc + "\n\n")
                            .font(.custom("muli", size: 18))
                            .lineLimit(3)
                            .foregroundColor(Color.darkGrey)
                            .padding(.leading, 15).padding(.bottom, 2)
                            .frame( alignment: .leading)
                            .padding(.trailing, 10)


                            AnimatedImage(url: URL(string: img))
                            .resizable()
                            .padding(.trailing, 15)
                            .frame( height: UIScreen.screenHeight * 0.08)
                                       .aspectRatio(16/9, contentMode: .fit)
                            .frame( alignment: .trailing)

                    }
        
    }
}

struct Fulllayouttype: View {
    @State var desc: String
    @State var img: String
    

    var body: some View {
        
        
                VStack{

                    Text(desc + "\n\n")
                        .font(.custom("muli", size: 18))
                        .lineLimit(3)
                        .foregroundColor(Color.darkGrey)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.leading, 16).padding(.trailing, 16).padding(.bottom, 2)



                        AnimatedImage(url: URL(string: img))
                        .resizable()
                        .padding(.bottom, -10)
                        .frame( height: UIScreen.screenHeight * 0.3)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)

                }
        
    }
}



struct Nonlayouttype: View {
    @State var desc: String
   
    

    var body: some View {
        
        
        VStack(){

                                Text(desc + "\n\n")
                                    .font(.custom("muli", size: 18))
                                    .lineLimit(3)
                                    .foregroundColor(Color.darkGrey)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.leading, 16).padding(.trailing, 16).padding(.bottom, 2)

        }
        
    }
}
