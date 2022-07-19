
import SwiftUI
import AlertToast

struct Home: View {
    
    @State private var showBottomSheet = false
  
    @EnvironmentObject var login: PostViewModel
    @State private var isHeaderViewVisible = false
    @State private var isScrollViewBouncing = false
    @State var timer = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State private var showAlert = false

    @AppStorage("id") var userloginID: String = ""
    
    @State private var showingAddUser = false
    @State private var showinglogout = false
    
    @AppStorage("First_Name") var name: String = ""

    
    var body: some View {
        
      
            
//            ZStack(alignment: .bottom) {
        NavigationView {
               GeometryReader { geometry in
                    ZStack(alignment: .top) {
                        VStack(spacing: 0) {
                            ScrollView {
                                GeometryReader { geometry in
                                    ZStack() {
                                        VStack(){
//                                            topheader()
                                            HStack(alignment: .center){
                                            Image(uiImage: UIImage(named: "logo_white")!)
                                                    .resizable()
                                                .frame(width: 40, height: 45, alignment: .leading)
                                               
                                                .padding(.leading,20)
                                               
                                                Spacer()
                                                NavigationLink(destination:
                                                                 GlobalView(endpoint: "namami-tate")) {
                                           Image(uiImage: UIImage(named: "namami")!)
                                                    .resizable()
                                                .frame(width: 45, height: 45, alignment: .leading)
//                                                .padding(.top, 90)
                                                .padding(.trailing,20)
//                                                .padding(.bottom,10)
                                                }
                                            }
                                            .padding(.top, 60)
                                            .padding(.bottom,10)
                                            HomeHeaderView(isPresented: $showingAddUser)
                                               
                                            .opacity(isHeaderViewVisible ? 0.0 : 1.0)
                                            
                                        }
                                        
                                    } //: HStack
                                    .frame(height: geometry.frame(in: .global).minY > 0 ? geometry.frame(in: .global).minY + 180 : 180)
                                    .background(Color.customblack2)
                                    .offset(y: geometry.frame(in: .global).minY > 0 ? -geometry.frame(in: .global).minY : 0)
                                } //: GeometryReader
                                .padding(.bottom, 125)
                                .zIndex(1)
                                
                                
                                GeometryReader { geometry in
                                    Text(" ")
                                        .onReceive(self.timer) { _ in
                                            if !isScrollViewBouncing {
                                                let globalFrame = geometry.frame(in: .global)
                                                
//                                                print("Gloabl frame: \(globalFrame)")
                                                /// Show Sticky Header View
                                                if globalFrame.origin.y <= 20 {
                                                    withAnimation {
                                                        isHeaderViewVisible = true
                                                    }
                                                } else { /// Hide Sticky Header View
                                                    withAnimation {
                                                        isHeaderViewVisible = false
                                                    }
                                                }
                                            }
                                        }
                                } //: GeometryReader
                                .frame(height: 50)
                                
                                if login.authenticated == 1 {
                                    profileheader()
                                        .padding(.vertical, 10)
                                    }
                             
                                
                                FeedRoomView(loginalert: $showAlert)
                                
                                  
                            } //: ScrollView
                        } //: VStack
                        
                        if isHeaderViewVisible {
                            ZStack(alignment: .bottom) {
                               HomeHeaderView(isPresented: $showingAddUser)
                                    .padding(.top, UIScreen.screenHeight * 0.08)
                               }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 100)
                            .background(Color.conditionbg)
                        }
                        
                        VStack {
                                           Spacer()
                                           
                                           HStack {
                                               Spacer()
                                               
                                               Button(action: {
                                                   if(userloginID.count != 0){
                                                   withAnimation {
                                                       self.showBottomSheet.toggle()
                                                   }
                                                   }else{
                                                       showAlert.toggle()
                                                   }
                                               }, label: {
                                                   Text("+")
                                                       .font(.system(.largeTitle))
                                                       .frame(width: 65, height: 60)
                                                       .foregroundColor(Color.black)
                                                       .padding(.bottom, 6)
                                               })
                                               .background(Color.customGrey)
                                               .cornerRadius(38.5)
                                               .padding()
                                               .shadow(color: Color.black.opacity(0.3),
                                                       radius: 3,
                                                       x: 3,
                                                       y: 3)
                                           } .toast(isPresenting: $showAlert){
                                               
                                             
                                               AlertToast(displayMode: .hud, type: .regular, title: "Please Login to Continue")
                                              
                                           }
                                       }
                                       
                                       BottomSheetModal(display: $showBottomSheet) {
                                           
                                           VStack(){
                                               
                                              
                                               
                                               NavigationLink(destination:
                                               GlobalView(endpoint: "volunteer")) {
                                                   HStack(spacing: 5){
                                                       Image(uiImage: UIImage(named: "stopwatch-thin")!)
                                                               .resizable()
                                                           .foregroundColor(Color.white)
                                                       .frame(width: 25, height: 25)
                                                       
                                                       Text("VOLUNTEER HOURS")
                                                           .font(.custom("Muli-regular", size: 18))
                                                           .frame(alignment:.leading)
                                                           .padding(.leading ,5)
                                                           .foregroundColor(Color.white)
                                                  Spacer()
                                                   }.padding()
                                               }
                                               
                                              
                                               
                                               
                                               
                                               NavigationLink(destination:
                                                                GlobalView(endpoint: "create-story")) {
                                                   HStack(spacing: 5){
                                                       Image(uiImage: UIImage(named: "messages-thin")!)
                                                               .resizable()
                                                           .foregroundColor(Color.white)
                                                       .frame(width: 25, height: 25)
                                                       
                                                       Text("CREATE STORY")
                                                           .font(.custom("Muli-regular", size: 18))
                                                           .frame(alignment:.leading)
                                                           .padding(.leading ,5)
                                                           .foregroundColor(Color.white)
                                                  Spacer()
                                                   }.padding()
                                               }
                                               
                                               NavigationLink(destination:
                                                                GlobalView(endpoint: "profile-challenges-goals#ongoingTab")) {
                                                   HStack(spacing: 5){
                                                       Image(uiImage: UIImage(named: "bullseye-arrow-thin")!)
                                                               .resizable()
                                                           .foregroundColor(Color.white)
                                                       .frame(width: 25, height: 25)
                                                       
                                                       Text("WEEKLY GOALS")
                                                           .font(.custom("Muli-regular", size: 18))
                                                           .frame(alignment:.leading)
                                                           .padding(.leading ,5)
                                                           .foregroundColor(Color.white)
                                                  Spacer()
                                                   }.padding()
                                               }
                                               
                                               NavigationLink(destination:
                                                                GlobalView(endpoint: "create-challenge")) {
                                                   HStack(spacing: 5){
                                                       Image(uiImage: UIImage(named: "fire-flame-thin")!)
                                                               .resizable()
                                                           .foregroundColor(Color.white)
                                                       .frame(width: 25, height: 25)
                                                       
                                                       Text("CREATE CHALLENGE")
                                                           .font(.custom("Muli-regular", size: 18))
                                                           .frame(alignment:.leading)
                                                           .padding(.leading ,5)
                                                           .foregroundColor(Color.white)
                                                  Spacer()
                                                   }.padding()
                                               }
                                               
                                               NavigationLink(destination:
                                                                GlobalView(endpoint: "people?type=Search")) {
                                                   HStack(spacing: 5){
                                                       Image(uiImage: UIImage(named: "user-thin")!)
                                                               .resizable()
                                                           .foregroundColor(Color.white)
                                                       .frame(width: 25, height: 25)
                                                       
                                                       Text("FRIENDS")
                                                           .font(.custom("Muli-regular", size: 18))
                                                           .frame(alignment:.leading)
                                                           .padding(.leading ,5)
                                                           .foregroundColor(Color.white)
                                                  Spacer()
                                                   }.padding()
                                               }
                                             
                                               
                                               Button(action: {
                                             
                                                   self.showinglogout = true
                                                   
                                               }) {
                                                   HStack(spacing: 5){
                                                       Image(uiImage: UIImage(named: "log-out-thin")!)
                                                               .resizable()
                                                           .foregroundColor(Color.white)
                                                       .frame(width: 25, height: 25)
                                                       
                                                       Text("LOG OUT")
                                                           .font(.custom("Muli-regular", size: 18))
                                                           .frame(alignment:.leading)
                                                           .padding(.leading ,5)
                                                           .foregroundColor(Color.white)
                                                  Spacer()
                                                   }.padding()
                                               }
                                               
                                           }
                                       }
                        
//                                       .sheet(isPresented: $showingAddUser) {
//                                           AddView(isPresented: $showingAddUser)
//                                       }
                        
                        
                        
                        if $showingAddUser.wrappedValue {
                                        // But it will not show unless this variable is true
                                        ZStack {
                                            Color.black.opacity(0.4)
                                                .edgesIgnoringSafeArea(.vertical)
                                                .onTapGesture{self.showingAddUser = false}
                                            // This VStack is the popup
                                            VStack(spacing:10) {
//                                                HStack{
                                                Text("Are you sure you want to jump into the live feed for all India ? You can come back to \(name) live feed at any time by clicking on \(name) logo.")
                                                        .padding(.horizontal)
                                                    .foregroundColor(Color.darkGrey)
//                                                    Spacer()
                                                
                                                
                                                
                                                
//                                                TextField("Enter Email ID")
//                                                           .padding()
//                                                           .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.darkGrey, style: StrokeStyle(lineWidth: 1.0)))
//                                                           .padding()
                                                
                                                
//                                                VStack{
                                                Button(action:{
                                                    UserDefaults.standard.set("PVT", forKey: "feedFlag")
                                                    
                                                    self.showingAddUser = false
                                                },label: {Text("Stay on \(name) Live Feed")
                                                        .frame(minWidth: UIScreen.screenWidth * 0.7)
                                                    
                                                }) .foregroundColor(Color.white)
                                                    .padding(10)
                                                    .background(Color.blue)
                                                    .cornerRadius(5)
                                                    .padding(.horizontal)
//                                                    .frame(maxWidth: .infinity)
                                                    .shadow(radius: 2)
                                                   
//                                                    .frame( height: 100)
                                                    
                                                    
                                               
                                                   
                                                Button(action:{
                                                    self.showingAddUser = false
                                                    UserDefaults.standard.set("PUB", forKey: "feedFlag")
                                                   
                                                },label: {Text("Take me to the Public Live Feed")
                                                        .frame(minWidth: UIScreen.screenWidth * 0.7)

                                                    
                                                })
                                                    .foregroundColor(Color.white)
                                                .padding(10)
                                                .background(Color.teal)
                                                .cornerRadius(5)
                                                .padding(.horizontal)
                                                .frame(maxWidth: .infinity)
                                                .onTapGesture{self.showingAddUser = false}
                                                .shadow(radius: 2)
//                                                .frame( height: 100)
                                               
//                                                }.padding()
                                                
                                            }.padding(.vertical)
//                                            .padding(5)
                                            .frame(width: UIScreen.screenWidth * 0.85)
                                            .background(Color.white)
                                            .cornerRadius(10).shadow(radius: 20)
//                                            .overlay(Rectangle()
//                                                .cornerRadius(5)
//                                                .frame(width: nil, height: 10, alignment: .top)
//                                                .foregroundColor(Color.blue), alignment: .top)

                                        }
                        }

                        
                        if $showinglogout.wrappedValue {
                                        // But it will not show unless this variable is true
                            ZStack {
                                Color.black.opacity(0.4)
                                    .edgesIgnoringSafeArea(.vertical)
                                    .onTapGesture{self.showinglogout = false}
                                // This VStack is the popup
                                VStack(spacing:2) {
                                    HStack{
                                    Text("Logout")
//                                            .padding(.horizontal)
                                        .foregroundColor(Color.black)
                                        .font(.custom("Muli-regular", size: 20))
                                        Spacer()
                                    }
                                    
                                    HStack{
                                    Text("Are you sure you want to Logout ?")
//                                            .padding(.horizontal)
                                        .foregroundColor(Color.black)
                                        .font(.custom("Muli-regular", size: 16))
                                    
                                    }
                                    
                                    HStack{
                                    Spacer()
                                        Text("CANCEL")
                                                .foregroundColor(Color.purple)
//                                            .padding(10)
                                            .font(.custom("Muli-regular", size: 15))
                                            .padding(.horizontal,5)
                                            .onTapGesture{self.showinglogout = false}
                                        
                                    Text("OK")
                                            .foregroundColor(Color.purple)
//                                        .padding(10)
                                        .font(.custom("Muli-regular", size: 15))
                                        .padding(.horizontal,5)
                                        .onTapGesture{
                                            logout()
                                            self.showinglogout = false
                                                 self.showBottomSheet.toggle()
                                        }
                                    }
                                    
                                  
                                    
                                }
                                .padding(.vertical)
                                .padding(.horizontal,20)
                                                                            .frame(width: UIScreen.screenWidth * 0.85)
                                                                            .background(Color.white)
                                                                            .cornerRadius(10).shadow(radius: 20)

                            }
                        }
                        
                        
                        
                        
                        
                    } //: ZStack
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity)
                    .background(Color.white)
                    .ignoresSafeArea()
                    .navigationBarHidden(true)
                
                    .edgesIgnoringSafeArea(.top)
                }
    }
//                VStack {
//
//
//
//                    HomeHeaderView ()
//
//
//                    ScrollView {
//                        VStack() {
//
//                            if login.authenticated == 1 {
//                                profileheader()
//                            }
//
//                            FeedRoomView()
//                            //
//
//
//
//
//                        }
//                        //                        .padding(.top, 22)
//                        //                        .padding(.bottom, 150)
//                    }
//                }
//                .padding(.top, 75)
                
               
                
                
//            }
            
    }
    func logout(){
        
        DispatchQueue.main.async {
            //Remove User Details
            UserDefaults.standard.removeObject( forKey: "Token")
            UserDefaults.standard.removeObject(forKey: "Profile_pic")
            UserDefaults.standard.removeObject( forKey: "Company_pic")
            UserDefaults.standard.removeObject(forKey: "organization")
            UserDefaults.standard.removeObject( forKey: "id")
            UserDefaults.standard.removeObject( forKey: "employerId")
            //Change Flag
            UserDefaults.standard.set("PUB", forKey: "feedFlag")
            //Change Auth
            login.authenticated = 0
            
        }
       
    }

}



struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environmentObject(RoomViewModel())
    }
}


struct AddView: View {
    @Binding var isPresented: Bool

    var body: some View {
        Button("Dismiss") {
            isPresented = false
        }
    }
}
