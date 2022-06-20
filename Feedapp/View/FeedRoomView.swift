
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
    @State var filteredcity: String = ""
    @State var filteredcityid: Int = 0
    var reqprofileid: String = ""
    var emptyempid: String = ""
//     var flag = UserDefaults.standard.string(forKey: "feedFlag")!;
    @AppStorage("feedFlag") var flag: String = ""
    @AppStorage("id") var userloginID: String = ""
    
    
    
    @Binding var loginalert: Bool
    
    
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
            
//            if (flag == "PUB") {
//                callapi()
//            }else if ( flag == "PVT") {
//                callapi()
//            }
            
            
            HStack{
            if (flag == "PUB") {
                Text("Public")
                    .font(.custom("muli", size: 15))
                        .foregroundColor(Color.black)
                    .padding(10)
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(20)
                    .padding(.horizontal)
                    .onTapGesture{
                        UserDefaults.standard.set("PVT", forKey: "feedFlag")
                        callapi()
                    }
            }
            
            
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
                       
                        apiCall().getUsers(lastid: 0, cityid: 0,profileid: reqprofileid,empid: checkFeedType()) { (users) in
                        self.req = users
                        filteredcity = ""
                        filteredcityid = 0
                        self.IsLoading = false
            //            print(req)
                    }
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
                                    
                                    apiCall().getUsers(lastid: 0, cityid: user.city,profileid: reqprofileid,empid: checkFeedType()) { (users) in
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
                            
                            
                            
                            
                            NavigationLink(destination: VolunteerEventRegisterView()) {

                        Image(uiImage: UIImage(named: setIcons(iconCount: user.feed_icon_count, iconType: user.feed_icon_type ))!)
                                .resizable()
                            .foregroundColor(Color.black)
                        .frame(width: 30, height: 35, alignment: .trailing)
                      
                            }
                        }
                        
                       
                    }                    .padding(.horizontal, 15)
                }
                
                    
                    
                    NavigationLink(destination: ProfilePageView(username: user.feedUserName,userid: user.userId)) {
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
                        
                        if(userloginID.count != 0){
                       
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
                            
                        }else{
                            loginalert = true
                        }
                       
                    }, label: {
                        Text("Likes (\(user.totalLikes))")
                            .font(Font.Muli.muli(size: 13))
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
                    
                    
                    
                    
                    if(userloginID.count != 0){



                        NavigationLink(destination: CommentView(need : user.name,needpostid: user.postId,needId: activityid(id: user.id,posttype: user.post_type))) {
                            Text("Comment (\(user.totalComments))")
                                .font(.custom("muli", size: 13))
                                .foregroundColor(Color.black)
                            Image(uiImage: UIImage(named: "message-thin")!)
                                    .resizable()
                                    .foregroundColor(Color.black)
                                .frame(width: 20, height: 20, alignment: .leading)

                        }





                    }else{
                    
                 
                        Button(action: {loginalert = true}, label: {
                            Text("Comment (\(user.totalComments))")
                                .font(.custom("muli", size: 13))
                                .foregroundColor(Color.black)
                            Image(uiImage: UIImage(named: "message-thin")!)
                                    .resizable()
                                    .foregroundColor(Color.black)
                                .frame(width: 20, height: 20, alignment: .leading)
                        })
                       
                        
                    }
                    
                    
                    
                    
                    
//                    .navigationBarTitle(Text(user.name))

                    Spacer()
                    Button(action: {shareit(sharelink: user.read_more_link)}, label: {
                        Text("Share")
                            .font(Font.Muli.muli(size: 13))
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
              
                        apiCall().getUsers(lastid: user.id, cityid: filteredcityid,profileid: reqprofileid,empid: checkFeedType()) { (users) in
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
        apiCall().getUsers(lastid: 0, cityid: filteredcityid,profileid: reqprofileid,empid: checkFeedType()) { (users) in
                           self.req = users
                           self.IsLoading = false
                       }

        
       
    } .onChange(of: flag) { newValue in
        self.IsLoading = true
       callapi()
    }
        
        
        if (req.isEmpty || IsLoading){
            ActivityIndicator()
                .frame(alignment: .center)
                .zIndex(1)
            
        }
    }
    }
    
    
    func callapi(){
        apiCall().getUsers(lastid: 0, cityid: filteredcityid,profileid: reqprofileid,empid: checkFeedType()) { (users) in
                           self.req = users
                           self.IsLoading = false
                       }

    }
    
    
    func checkFeedType() -> String {
        self.IsLoading = true
        // Get Flag
        print("STEP", "Get Flag");
        @AppStorage("feedFlag") var flag: String = ""

        if (flag.count > 0) {
            // Flag has value
            // Check Flag
            print("STEP", "Flag has value, Check Flag");
            if (flag == "PUB") {
//                DispatchQueue.main.async {
                // Show Public Feed
                print("STEP", "Show Public Feed");
                    return emptyempid
//                return showPublic(context, cat, lastId, city);
//                apiCall().getUsers(lastid: 0, cityid: filteredcityid,profileid: reqprofileid,empid: emptyempid) { (users) in
//                    self.req = users
//                    self.IsLoading = false
//        //            print(req)
//                }
//                }
            } else {
                // Login Check
                print("STEP", "Login Check");
                let userID = UserDefaults.standard.string(forKey: "id")

                if (userID != nil) {
                    // User logged In
                    // Get Organization
                    print("STEP", "User logged In, Get Organization");
                    let org = UserDefaults.standard.string(forKey: "organization");
                    if (org == "1") {
                        // Individual User
                        // Check Employer
                        print("STEP", "Check Employer");
                        let employerId = UserDefaults.standard.string(forKey: "employerId");
                        
                        if (employerId !=  nil) {
                            // Have Employer
                            print("STEP", "Have Employer");
                            
                            let empId = employerId?.data(using: .utf8)!.base64EncodedString()
                            // Show Private Feed (based on Employer ID)
                            print("STEP", "Show Private Feed (based on Employer ID)",empId);
                            return empId!
//                            return showPrivate(context, cat, lastId, city, empId);
//                            DispatchQueue.main.async {
//                            apiCall().getUsers(lastid: 0, cityid: filteredcityid,profileid: reqprofileid,empid: empId) { (users) in
//                                self.req = users
//                                self.IsLoading = false
//                            }
//                            }
                        } else {
                            // Doesn't have Employer
                            // Show Public Feed
                            print("STEP", "Doesn't have Employer, Show Public Feed");
                            return emptyempid
//                            return showPublic(context, cat, lastId, city);
//                            apiCall().getUsers(lastid: 0, cityid: filteredcityid,profileid: reqprofileid,empid: emptyempid) { (users) in
//                                self.req = users
//                                self.IsLoading = false
//                            }
                        }

                    } else {
                        // Employer ID is ID
                        // Show Private Feed
                        let empId = userID!.data(using: .utf8)!.base64EncodedString()
                        print("STEP", "Employer ID is ID, Show Private Feed");
                        return empId
//                        return showPrivate(context, cat, lastId, city, empId);
//                        apiCall().getUsers(lastid: 0, cityid: filteredcityid,profileid: reqprofileid,empid: empId) { (users) in
//                            self.req = users
//                            self.IsLoading = false
//                        }
                    }
                } else {
                    // Show Public Feed
                    print("STEP", "Show Public Feed");
                    return emptyempid
//                    return showPublic(context, cat, lastId, city);
//                    apiCall().getUsers(lastid: 0, cityid: filteredcityid,profileid: reqprofileid,empid: emptyempid) { (users) in
//                        self.req = users
//                        self.IsLoading = false
//                    }
                }
            }
        } else {
            // Flag is empty
            // Login Check
            print("STEP", "Flag is empty, Login Check");
            let id = UserDefaults.standard.string(forKey: "id");

            if (id!.count > 0) {
                // Logged In
                // Organization Check
                print("STEP", "User logged In, Get Organization");
                let org = UserDefaults.standard.string(forKey: "organization");
                if (org == "1") {
                    // Individual User
                    // Employer check
                    print("STEP", "Individual User, Employer check");
                    let employerId = UserDefaults.standard.string(forKey: "employerId");
                    if (employerId != "0") {
                        // Have Employer
                        print("STEP", "Have Employer");
                        let empId = employerId!.data(using: .utf8)!.base64EncodedString()
                        // Show Private Feed (based on Employer ID)
                        print("STEP", "Show Private Feed (based on Employer ID)");
                        return empId
//                        return showPrivate(context, cat, lastId, city, empId);
//                        apiCall().getUsers(lastid: 0, cityid: filteredcityid,profileid: reqprofileid,empid: empId) { (users) in
//                            self.req = users
//                            self.IsLoading = false
//                        }
                    } else {
                        // Doesn't have Employer
                       
                        // Show Public Feed
                        print("STEP", "Doesn't have Employer, Show Public Feed");
                        return emptyempid
//                        return showPublic(context, cat, lastId, city);
//                        apiCall().getUsers(lastid: 0, cityid: filteredcityid,profileid: reqprofileid,empid: emptyempid) { (users) in
//                            self.req = users
//                            self.IsLoading = false
//                        }
                    }
                } else {
                    // Corporate, Non-Profit User
                    // Show Private Feed (based on ID)
                    print("STEP", "Corporate, Non-Profit User, Show Private Feed (based on ID)");
                    
                    let empId = id!.data(using: .utf8)!.base64EncodedString()
                    return empId
//                    return showPrivate(context, cat, lastId, city, empId);
//                    apiCall().getUsers(lastid: 0, cityid: filteredcityid,profileid: reqprofileid,empid: empId) { (users) in
//                        self.req = users
//                        self.IsLoading = false
//                    }
                }
            } else {
                // Not logged In
                // Show Public Feed
                print("STEP", "Not logged In, Show Public Feed");
                return emptyempid
//                return showPublic(context, cat, lastId, city);
//                apiCall().getUsers(lastid: 0, cityid: filteredcityid,profileid: reqprofileid,empid: emptyempid) { (users) in
//                    self.req = users
//                    self.IsLoading = false
//                }
            }
        }
    }

    
    
    
    
    
    
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
        DispatchQueue.main.async {
            print("like succedd")
                   }
      
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
    ZStack(alignment: .topTrailing){
       
    ZoomableScrollView {
        
        
        AnimatedImage(url: URL(string: showimg))
        .resizable()
        .frame( height: UIScreen.screenHeight * 0.4)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
        
      }
        VStack{
        Image(uiImage: UIImage(named: "circle-xmark-solid")!)
                .resizable()
                .foregroundColor(Color.black)
            .frame(width: 50, height: 50)
            .zIndex(99999)
            .offset(x: -10 ,y: 10)

        
            .onTapGesture {
                presentationMode.wrappedValue.dismiss()
            }
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

