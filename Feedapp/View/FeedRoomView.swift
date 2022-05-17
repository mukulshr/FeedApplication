
import SwiftUI
import SDWebImageSwiftUI

struct FeedRoomView: View {
    
//    let room: FeedRoom
    private let size: CGFloat = 50
    @State private var showsBottomSheet: Bool = false
    @State var req: [reqdata] = []
    
    
    func activityid(id: Int,posttype: String) -> Int {
        if (posttype == "0") {
               return 0;
           } else {
               return id;
           }

    }


    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            
            
            
            if (req.isEmpty ){
                ProgressView("Loading...")
//                Text("Loading...")
                
            }else{
            ForEach(req, id: \.id) { user in
            
            
                   
//            Text(room.roomName)
//                .font(Font.Nunito.bold(size: 16))
//                .foregroundColor(Color.textBlack)
//
            VStack(alignment: .leading, spacing: 10) {
                if let groupName = user.feed_type_name {
                    HStack(spacing: 3) {
                        Image
                            .home
                            .font(Font.Nunito.bold(size: 20))
                            .foregroundColor(Color.customGreen)
                        VStack(alignment: .leading){
                            Text(user.cityName.uppercased())
                            .font(Font.Nunito.bold(size: 14))
                            .foregroundColor(Color.textBlack)
                            Text(user.feedDate.uppercased())
                                .font(Font.Nunito.bold(size: 10))
                                .foregroundColor(Color.textBlack)
                        }
                       
                    }                    .padding(.horizontal, 15)
                }
                
                HStack(){
                   AnimatedImage(url: URL(string: user.feedUserPic))
                        .resizable()
                        .frame(width: size, height: size)
                        .cornerRadius(25)
                    Text(user.feedUserName)
                        .foregroundColor(Color.black)
                    .padding(.trailing, 5)
                    .font(.system(size: 16))
                }.padding(.horizontal, 15)
                    .onAppear(){
                       print(user.id)
                   }
                   
                
                VStack{
               
                    Text(user.storyDescription + "\n\n")
                        .lineLimit(3)
                        .foregroundColor(Color.black)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(.system(size: 14))
                        .padding(.leading, 16).padding(.trailing, 16).padding(.bottom, 2)
                
                }
//                    ForEach(room.participants, id: \.self) {
//                        Text("\($0) 💬")
//                    }
//                    .font(Font.Nunito.bold(size: 16))
//                    .foregroundColor(Color.textBlack)
//
                    
                    
                    if user.story_img != nil{
                        AnimatedImage(url: URL(string: user.story_img))
                        .resizable()
                        .padding(.bottom, -20)
                        .frame( height: 230)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                    }
                
              
                VStack(alignment:.leading){
                    Text(user.category_name)
                            .foregroundColor(.white)
                        .font(Font.Nunito.bold(size: 13))
                        Text(user.name)
                            .foregroundColor(.white)
                        .font(Font.Nunito.bold(size: 18))
                    } .frame( height: size)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
                        .background(Rectangle().fill( LinearGradient(gradient: Gradient(colors: [.gradientdark, .gradientlight]), startPoint: .leading, endPoint: .trailing)
                                                    ))
                    
                        
                    
           
                
                HStack() {
                    
                    Button(action: {
                        like(id: user.category_name)
                    }, label: {
                        Text("Like(0)")
                            .font(Font.Nunito.bold(size: 16))
                            .foregroundColor(Color.black)
                    })
                    

                    Spacer()
                    
                    NavigationLink(destination: CommentView(need : user.category_name,needpostid: user.postId,needId: activityid(id: user.id,posttype: user.post_type))) {
                        Text("Comment")
                            .font(Font.Nunito.bold(size: 16))
                            .foregroundColor(Color.black)
                    
                    }.navigationBarTitle(Text(user.name))

                    Spacer()
                    Button(action: {
                        like(id: user.category_name)
                    }, label: {
                        Text("Share(0)")
                            .font(Font.Nunito.bold(size: 16))
                            .foregroundColor(Color.black)
                    })
                    
                    
                   
                    
                }
                
                
                .padding(.horizontal, 15)
//                .padding(.top, 10)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                       maxHeight: 60,
                       alignment: .top)
                
            }
//            .onAppear(){
//                if user == self.req.last {
//                    lasts()
////           print("last....")
////                            Text(user.id)
//       }
//}
//
                
           
           
                
               
            }
        .padding(.vertical, 5)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
        .background(Color.cardBackground)
        .padding(.horizontal, 15)
            }
            
            
        
    }.onAppear {
        apiCall().getUsers { (users) in
            self.req = users
//            print(req)
        }
       
    }
    }
}



func lasts(){
    print("lasting")
}

func like(id: String) {
    let parameters = "{\r\n    \"action\": \"like\",\r\n    \"data\": {\r\n        \"interaction\": \"like\",\r\n        \"actionType\": \"create\",\r\n        \"postId\": 1058,\r\n        \"activityId\": 219\r\n    }\r\n}"
    let postData = parameters.data(using: .utf8)

    var request = URLRequest(url: URL(string: "https://www.mysuperhumanrace-uat.com/api/liveFeedApis")!,timeoutInterval: Double.infinity)
    request.addValue("eyJpdiI6Iko3VUtOMzBtOUdzWHkrT01FMWtlMHc9PSIsInZhbHVlIjoickdrNWNidjlPTXpZVm1NdVVDNDM3dz09IiwibWFjIjoiNDg4ZjEwNjQ0NzM2NTcxNGFiNzc5NGJiYjk1Y2Q4MWM5YmE2M2MyNzI5ODdhMzRkOTEwYjUwMmM0YTQ4MzgzNCJ9", forHTTPHeaderField: "Authorization")
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    request.httpMethod = "POST"
    request.httpBody = postData

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else {
        print("error")
        return
      }
      print("succedd")
    }

    task.resume()

}


struct FeedRoomView_Previews: PreviewProvider {
    static var previews: some View {
        FeedRoomView()
            .preferredColorScheme(.dark)
    }
}


