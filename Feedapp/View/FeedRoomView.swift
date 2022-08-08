
import SwiftUI
import SDWebImageSwiftUI
import WebKit
import RichText
import AttributedText


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
    @State private var AuthToken = UserDefaults.standard.string(forKey: "Token")
    
    
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
    
    
    
    func weblink(webview: String,readmore: String) -> String {
        if webview != "" {
            return webview;
        } else {
            return readmore;
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
                            .background(Color.customGrey)
                            .cornerRadius(20)
                            .padding(.horizontal)
                            .onTapGesture{
                                if(userloginID.count != 0){
                                    UserDefaults.standard.set("PVT", forKey: "feedFlag")
                                    callapi()
                                }else{
                                    loginalert = true
                                }
                                
                            }
                    }
                    
                    
                    if (filteredcity != ""){
                        
                        Text(filteredcity)
                            .font(.custom("muli", size: 15))
                            .foregroundColor(Color.black)
                            .padding(10)
                            .background(Color.customGrey)
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
                
                
                
                LazyVStack(spacing: 15){
                    ForEach(req, id: \.id) { user in
                        
                        
                        
               
                        LazyVStack(alignment: .leading, spacing: 10) {
                            if let groupName = user.feed_type_name {
                                HStack() {
                                    Image(uiImage: UIImage(named: "location-thin")!)
                                        .resizable()
                                        .foregroundColor(Color.black)
                                        .frame(width: 22, height: 30, alignment: .leading)
                                    
                                    VStack(alignment: .leading, spacing: 4){
                                        Text("\(user.cityName) , \(user.stateName)")
                                            .font(Font.Muli.muli(size: 14))
                                            .textCase(.uppercase)

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
                                        
                                        
                                            .foregroundColor(Color.primarycolor)
                                        
                                        
                                        Text(user.feedDate)
                                            .font(Font.Muli.muli(size: 14))
                                        
                                            .foregroundColor(Color.customteal)
                                    }
                                    
                                    Spacer()
                                    
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
                                        VStack(spacing: 0){
                                            
                                            
                                            
                                            if user.userLike == "0"{
                                                Image(uiImage: UIImage(named: "heart-thin")!)
                                                    .resizable()
                                                    .foregroundColor(Color.red)
                                                    .frame(width: 15, height: 15, alignment: .leading)
                                            }else if user.userLike == "1"{
                                                
                                                Image(uiImage: UIImage(named: "heart-solid")!)
                                                    .resizable()
                                                    .foregroundColor(Color.red)
                                                    .frame(width: 15, height: 15, alignment: .leading)
                                            }
                                            Text("\(user.totalLikes)")
                                                .font(Font.Muli.muli(size: 14))
                                                .foregroundColor(Color.red)
                                            
                                        }
                                        
                                        
                                    })
                                    
                                    
                                    
                                }
                                .padding(.top, 5)
                            }
                            
                            
                            
                            NavigationLink(destination: ProfilePageView(username: user.feedUserName,userid: user.userId)) {
                                HStack(){
                                    AnimatedImage(url: URL(string: user.feedUserPic))
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .cornerRadius(25)
                                    Text(user.feedUserName)
                                        .foregroundColor(Color.primarycolor)
                                        .padding(.trailing, 5)
                                        .font(.custom("muli", size: 13))
                                    Spacer()
                                    if user.feed_icon_type.count > 0{
                                        
                                        
                                        if(user.webview_link != "popup"){
                                            
                                            NavigationLink(destination:
                                                            GlobalView(endpoint: weblink(webview: user.webview_link, readmore: user.read_more_link))
                                            ) {
                                                
                                                Image(uiImage: UIImage(named: setIcons(iconCount: user.feed_icon_count, iconType: user.feed_icon_type ))!)
                                                    .resizable()
                                                    .foregroundColor(Color.primarycolor)
                                                    .frame(width: 30, height: 30, alignment: .trailing)
                                                
                                            }
                                        }else{
                                            
                                            if(userloginID.count != 0){
                                                
                                                NavigationLink(destination:
                                                                VolunteerEventRegisterView(postid: user.postId)
                                                ) {
                                                    
                                                    Image(uiImage: UIImage(named: setIcons(iconCount: user.feed_icon_count, iconType: user.feed_icon_type ))!)
                                                        .resizable()
                                                        .foregroundColor(Color.black)
                                                        .frame(width: 30, height: 30, alignment: .trailing)
                                                    
                                                }
                                                
                                            }else{
                                                
                                                NavigationLink(destination:
                                                                GlobalView(endpoint: weblink(webview: user.webview_link, readmore: user.read_more_link))
                                                ) {
                                                    
                                                    Image(uiImage: UIImage(named: setIcons(iconCount: user.feed_icon_count, iconType: user.feed_icon_type ))!)
                                                        .resizable()
                                                        .foregroundColor(Color.black)
                                                        .frame(width: 30, height: 30, alignment: .trailing)
                                                    
                                                }
                                                
                                                
                                            }
                                            
                                            
                                            
                                        }
                                        
                                        
                                    }
                                    
                                }  .padding(.vertical, 15)
                            }
                            
                            
                            
                            
                            NavigationLink(destination:
                                            GlobalView(endpoint: weblink(webview: user.webview_link, readmore: user.read_more_link))
                            ) {
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
                                
                                VStack(alignment: .leading){
                                    
                                    HStack{
                                        Text(user.category_name)
                                            .frame(alignment: .leading)
                                            .foregroundColor(Color.darkGrey)
                                            .font(Font.Muli.muli(size: 14))
                                            .padding(.horizontal,10)
                                            .padding(5)
                                            .background(
                                                ArrowShape()
                                                    .fill(Color.labelcolor))
                                        
                                        Spacer()
                                    }
                                    Text(user.name)
                                        .foregroundColor(Color.darkGrey)
                                        .font(Font.Muli.muli(size: 14))
                                        .padding(.leading, 5)
                                    
                                    //                            Group {
                                    //                                Text(user.category_name)
                                    //
                                    //                                         +
                                    //                                Text(user.name)
                                    //                            }
                                }
                                
                            }.buttonStyle(FlatLinkStyle())
                            
                            
                            
                            HStack() {
                                Button(action: {shareit(sharelink: user.read_more_link)}, label: {
                                    Image(uiImage: UIImage(named: "share-icon")!)
                                        .resizable()
                                        .foregroundColor(Color.textYellow)
                                        .frame(width: 15, height: 15, alignment: .leading)
                                    Text("Share")
                                        .font(Font.Muli.muli(size: 14))
                                        .foregroundColor(Color.darkGrey)
                                    
                                    
                                })
                                
                                
                                Spacer()
                                
                                
                                
                                
                                if(userloginID.count != 0){
                                    
                                    
                                    
                                    NavigationLink(destination: CommentView(need : user.name,needpostid: user.postId,needId: activityid(id: user.id,posttype: user.post_type))) {
                                        Image(uiImage: UIImage(named: "message-thin")!)
                                            .resizable()
                                            .foregroundColor(Color.textYellow)
                                            .frame(width: 15, height: 15, alignment: .leading)
                                        Text("Comment")
                                            .font(.custom("muli", size: 14))
                                            .foregroundColor(Color.darkGrey)
                                        
                                        
                                    }
                                    
                                    
                                    
                                    
                                    
                                }else{
                                    
                                    
                                    Button(action: {loginalert = true}, label: {
                                        Image(uiImage: UIImage(named: "message-thin")!)
                                            .resizable()
                                            .foregroundColor(Color.textYellow)
                                            .frame(width: 15, height: 15, alignment: .leading)
                                        Text("Comment")
                                            .font(.custom("muli", size: 14))
                                            .foregroundColor(Color.darkGrey)
                                        
                                    })
                                    
                                    
                                }
                                
                                
                                
                                
                                
                                //                    .navigationBarTitle(Text(user.name))
                                
                                Spacer()
                                if(userloginID.count != 0){
                                    
                                    
                                    
                                    NavigationLink(destination: CommentView(need : user.name,needpostid: user.postId,needId: activityid(id: user.id,posttype: user.post_type))) {
                                        Image(uiImage: UIImage(named: "messages-light")!)
                                            .resizable()
                                            .foregroundColor(Color.textYellow)
                                            .frame(width: 20, height: 15, alignment: .leading)
                                        Text("\(user.totalComments) Comment")
                                            .font(.custom("muli", size: 14))
                                            .foregroundColor(Color.darkGrey)
                                        
                                        
                                    }
                                    
                                    
                                    
                                    
                                    
                                }else{
                                    
                                    
                                    Button(action: {loginalert = true}, label: {
                                        Image(uiImage: UIImage(named: "messages-light")!)
                                            .resizable()
                                            .foregroundColor(Color.textYellow)
                                            .frame(width: 20, height: 15, alignment: .leading)
                                        Text("\(user.totalComments) Comment")
                                            .font(.custom("muli", size: 14))
                                            .foregroundColor(Color.darkGrey)
                                        
                                    })
                                    
                                    
                                }
                                
                                
                                
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
                            
                            
                            //                .padding(.horizontal, 15)
                            //                .padding(.top, 10)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                                   maxHeight: 60,
                                   alignment: .top)
                            
                        }
                        
                        
                        
                        
                        
                    }
                    
                    .padding(.vertical, 5)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                    .background(Color.white)
                    .padding(.horizontal, 15)
                    //        .border(Color.gray)
                    .border(Color.customGrey, width: 1)
                }
                .padding(.horizontal, 10)
                
                
                
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
                // Show Public Feed
                print("STEP", "Show Public Feed");
                return emptyempid
            } else {
                // Login Check
                print("STEP", "Login Check");
                //                let userID = UserDefaults.standard.string(forKey: "id")
                @AppStorage("id") var userID: String = ""
                
                //                if (userID != nil) {
                if(userID.count != 0){
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
                        } else {
                            print("STEP", "Doesn't have Employer, Show Public Feed");
                            return emptyempid
                        }
                        
                    } else {
                        
                        let empId = userID.data(using: .utf8)!.base64EncodedString()
                        print("STEP", "Employer ID is ID, Show Private Feed");
                        return empId
                    }
                } else {
                    print("STEP", "Show Public Feed");
                    return emptyempid
                }
            }
        } else {
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
                    } else {
                        print("STEP", "Doesn't have Employer, Show Public Feed");
                        return emptyempid
                    }
                } else {
                    // Corporate, Non-Profit User
                    // Show Private Feed (based on ID)
                    print("STEP", "Corporate, Non-Profit User, Show Private Feed (based on ID)");
                    
                    let empId = id!.data(using: .utf8)!.base64EncodedString()
                    return empId
                }
            } else {
                // Not logged In
                // Show Public Feed
                print("STEP", "Not logged In, Show Public Feed");
                return emptyempid
            }
        }
    }
    
    
    
    
    
    
    
}



func like(needpostid: Int,needId: Int) {
    @State var AuthToken = UserDefaults.standard.string(forKey: "Token")
    let parameters = "{\r\n    \"action\": \"like\",\r\n    \"data\": {\r\n        \"interaction\": \"like\",\r\n        \"actionType\": \"create\",\r\n        \"postId\": \(needpostid),\r\n        \"activityId\": \(needId)\r\n    }\r\n}"
    let postData = parameters.data(using: .utf8)
    
    var request = URLRequest(url: URL(string: "https://www.mysuperhumanrace-uat.com/api/socialApis")!,timeoutInterval: Double.infinity)
    request.addValue(AuthToken!, forHTTPHeaderField: "Authorization")
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
    @State  var AuthToken = UserDefaults.standard.string(forKey: "Token")
    let parameters = "{\r\n    \"action\": \"like\",\r\n    \"data\": {\r\n        \"interaction\": \"like\",\r\n        \"actionType\": \"delete\",\r\n        \"postId\": \(needpostid),\r\n        \"activityId\": \(needId)\r\n    }\r\n}"
    let postData = parameters.data(using: .utf8)
    
    var request = URLRequest(url: URL(string: "https://www.mysuperhumanrace-uat.com/api/socialApis")!,timeoutInterval: Double.infinity)
    request.addValue(AuthToken!, forHTTPHeaderField: "Authorization")
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
            
            AttributedText(desc + "\n\n")
                .font(.custom("muli", size: 13))
                .lineLimit(3)
            
                .foregroundColor(Color.black)
            //                            .padding(.leading, 15)
                .padding(.bottom, 2)
                .frame( alignment: .leading)
            //                            .padding(.trailing, 10)
            
            
            AnimatedImage(url: URL(string: img))
                .resizable()
              
                .padding(.trailing, 15)
                .frame( height: UIScreen.screenHeight * 0.04)
                .frame(width: UIScreen.screenWidth * 0.2)
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
            
            AttributedText(desc + "\n\n")
                .font(.custom("muli", size: 13))
                .lineLimit(3)
                .foregroundColor(Color.black)
                .fixedSize(horizontal: false, vertical: true)
            //                        .padding(.leading, 16).padding(.trailing, 16)
                .padding(.bottom, 2)
            
            
            
            AnimatedImage(url: URL(string: img))
                .resizable()
                
                .frame( height: UIScreen.screenHeight * 0.25)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .center)
                .aspectRatio(CGSize(width:50, height: 50), contentMode: .fit)
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
            
            AttributedText(desc + "\n\n")
                .font(.custom("muli", size: 13))
                .lineLimit(3)
                .foregroundColor(Color.black)
                .fixedSize(horizontal: false, vertical: true)
            //                                    .padding(.leading, 16).padding(.trailing, 16)
                .padding(.bottom, 2)
            
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



struct ArrowShape: Shape {
    func path(in rect: CGRect) -> Path {
        let xOffset = rect.size.width * 0.07
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.size.width - xOffset, y: 0))
        path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height / 2))
        path.addLine(to: CGPoint(x: rect.size.width - xOffset, y: rect.size.height))
        path.addLine(to: CGPoint(x: 0, y: rect.size.height))
        //        path.addLine(to: CGPoint(x: xOffset, y: rect.size.height / 2))
        path.closeSubpath()
        return path
    }
}


struct ArrowButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .font(Font.Muli.muli(size: 14))
        //            .padding(.horizontal,50)
            .padding(5)
            .background(
                ArrowShape()
                    .fill(Color.cardShadowTint))
        //            .shadow(color:.black, radius: configuration.isPressed ? 2 : 4)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}



struct FlatLinkStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
