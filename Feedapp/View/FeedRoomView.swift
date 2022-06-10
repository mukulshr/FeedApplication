
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
                            Text(user.cityName)
                                .font(Font.Muli.muli(size: 14))

                            .foregroundColor(Color.black)
                            Text(user.feedDate)
                                .font(Font.Muli.muli(size: 10))

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
                            like(needpostid: user.postId,needId: activityid(id: user.id,posttype: user.post_type))
                        
                        }else if user.userLike == "1"{
                            dislike(needpostid: user.postId,needId: activityid(id: user.id,posttype: user.post_type))
                        
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
                    
                    }.navigationBarTitle(Text(user.name))

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
                    
        .padding(.vertical, 5)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
        .background(Color.cardBackground)
        .padding(.horizontal, 5)
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
    @State private var showModal = false


    var body: some View {
        
                    HStack(){

                        Text(desc + "\n\n")
                            .font(.custom("muli", size: 16))
                            .lineLimit(3)
                            .foregroundColor(Color.darkGrey)
                            .padding(.leading, 15).padding(.bottom, 2)
                            .frame( alignment: .leading)
                            .padding(.trailing, 10)


                            AnimatedImage(url: URL(string: img))
                            .resizable()
                            .padding(.trailing, 15)
                            .frame( height: UIScreen.screenHeight * 0.1)
                                       .aspectRatio(16/9, contentMode: .fit)
                            .frame( alignment: .trailing)
                            .onTapGesture {
                                showModal = true
                            }.fullScreenCover(isPresented: $showModal) {
                                ModalView(showimg: img)
                            }
                        
                        

                    }
        
    }
}

struct Fulllayouttype: View {
    @State var desc: String
    @State var img: String
    @State private var showModal = false

    var body: some View {
        
        
                VStack{

                    Text(desc + "\n\n")
                        .font(.custom("muli", size: 16))
                        .lineLimit(3)
                        .foregroundColor(Color.darkGrey)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.leading, 16).padding(.trailing, 16).padding(.bottom, 2)



                        AnimatedImage(url: URL(string: img))
                        .resizable()
                        .padding(.bottom, -10)
                        .frame( height: UIScreen.screenHeight * 0.3)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                        .onTapGesture {
                            showModal = true
                        }.fullScreenCover(isPresented: $showModal) {
                            ModalView(showimg: img)
                        }

                }
        
    }
}



struct Nonlayouttype: View {
    @State var desc: String
   
    

    var body: some View {
        
        
        VStack(){

                                Text(desc + "\n\n")
                                    .font(.custom("muli", size: 16))
                                    .lineLimit(3)
                                    .foregroundColor(Color.darkGrey)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.leading, 16).padding(.trailing, 16).padding(.bottom, 2)

        }
        
    }
}









func setIcons(iconCount: Int,iconType: String) -> String {
    if (iconType.count > 0) {

            switch (iconType) {
                case "person":
                    if (iconCount == 0) {
                        return "person-sign-thin"
                    } else {
                       return "person-sign-solid"
                    }
                   
                case "puzzle":
                    if (iconCount == 0) {
                        return "puzzle-piece-thin"
                    } else {
                        return "puzzle-piece-solid"
                    }
                   
                case "poll":
                    if (iconCount == 0) {
                        return "square-poll-vertical-thin"
                    } else {
                        return "square-poll-vertical-solid"
                    }
                   
                case "question":
                    if (iconCount == 0) {
                        return "square-question-thin"
                    } else {
                        return "square-question-solid"
                    }
                   
                case "balance":
                    if (iconCount == 0) {
                        return "scale-balanced-thin"
                    } else {
                        return "scale-balanced-solid"
                    }
                   
                case "wallet":
                    if (iconCount == 0) {
                        return "wallet-thin"
                    } else {
                        return "wallet-solid"
                    }
                   
                case "superpower_circlecheck":
                    if (iconCount == 0) {
                        return "superpowers-brands"
                    } else {
                        return "circle-check-solid"
                    }
                   
                case "holding_box":
                    if (iconCount == 0) {
                        return "hand-holding-box-thin"
                    } else {
                        return "hand-holding-box-solid"
                    }
                   
            default:
                return "location-thin"
            }

           
        }
    return ""
    
}



struct ModalView: View {
    @State var showimg: String
@Environment(\.presentationMode) var presentationMode
var body: some View {
    ZStack{
       
    ZoomableScrollView {
        Image(uiImage: UIImage(named: "heart-solid")!)
                .resizable()
                .foregroundColor(Color.red)
            .frame(width: 20, height: 20, alignment: .topTrailing)
        
            .onTapGesture {
                presentationMode.wrappedValue.dismiss()
            }
        
        AnimatedImage(url: URL(string: showimg))
        .resizable()
        .frame( height: UIScreen.screenHeight * 0.4)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
        
      }
       
    }
}
}


struct ZoomableScrollView<Content: View>: UIViewRepresentable {
  private var content: Content

  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  func makeUIView(context: Context) -> UIScrollView {
    // set up the UIScrollView
    let scrollView = UIScrollView()
    scrollView.delegate = context.coordinator  // for viewForZooming(in:)
    scrollView.maximumZoomScale = 20
    scrollView.minimumZoomScale = 1
    scrollView.bouncesZoom = true

    // create a UIHostingController to hold our SwiftUI content
    let hostedView = context.coordinator.hostingController.view!
    hostedView.translatesAutoresizingMaskIntoConstraints = true
    hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    hostedView.frame = scrollView.bounds
    scrollView.addSubview(hostedView)

    return scrollView
  }

  func makeCoordinator() -> Coordinator {
    return Coordinator(hostingController: UIHostingController(rootView: self.content))
  }

  func updateUIView(_ uiView: UIScrollView, context: Context) {
    // update the hosting controller's SwiftUI content
    context.coordinator.hostingController.rootView = self.content
    assert(context.coordinator.hostingController.view.superview == uiView)
  }

  // MARK: - Coordinator

  class Coordinator: NSObject, UIScrollViewDelegate {
    var hostingController: UIHostingController<Content>

    init(hostingController: UIHostingController<Content>) {
      self.hostingController = hostingController
    }

    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
      return hostingController.view
    }
  }
}

