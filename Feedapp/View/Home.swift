
import SwiftUI

struct Home: View {
    
    @State private var showBottomSheet = false
  
    @EnvironmentObject var login: PostViewModel
    @State private var isHeaderViewVisible = false
    @State private var isScrollViewBouncing = false
    @State var timer = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    
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
                                           Image(uiImage: UIImage(named: "namami")!)
                                                    .resizable()
                                                .frame(width: 45, height: 45, alignment: .leading)
//                                                .padding(.top, 90)
                                                .padding(.trailing,20)
//                                                .padding(.bottom,10)
                                            }
                                            .padding(.top, 60)
                                            .padding(.bottom,10)
                                            HomeHeaderView()
                                               
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
                             
                                
                                FeedRoomView()
                                
                                  
                            } //: ScrollView
                        } //: VStack
                        
                        if isHeaderViewVisible {
                            ZStack(alignment: .bottom) {
                               HomeHeaderView()
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
                                                   withAnimation {
                                                       self.showBottomSheet.toggle()
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
                                           }
                                       }
                                       
                                       BottomSheetModal(display: $showBottomSheet) {
                                           
                                           VStack(){
                                               
                                              
                                               
                                               NavigationLink(destination:
                                               VolunteerView()) {
                                                   HStack(spacing: 5){
                                                       Image(uiImage: UIImage(named: "stopwatch-thin")!)
                                                               .resizable()
                                                           .foregroundColor(Color.white)
                                                       .frame(width: 25, height: 25)
                                                       
                                                       Text("VOLUNTEER HOURS")
                                                           .font(.custom("muli", size: 18))
                                                           .frame(alignment:.leading)
                                                           .padding(.leading ,5)
                                                           .foregroundColor(Color.white)
                                                  Spacer()
                                                   }.padding()
                                               }
                                               
                                              
                                               
                                               
                                               
                                               NavigationLink(destination:
                                               VolunteerView()) {
                                                   HStack(spacing: 5){
                                                       Image(uiImage: UIImage(named: "messages-thin")!)
                                                               .resizable()
                                                           .foregroundColor(Color.white)
                                                       .frame(width: 25, height: 25)
                                                       
                                                       Text("CREATE STORY")
                                                           .font(.custom("muli", size: 18))
                                                           .frame(alignment:.leading)
                                                           .padding(.leading ,5)
                                                           .foregroundColor(Color.white)
                                                  Spacer()
                                                   }.padding()
                                               }
                                               
                                               NavigationLink(destination:
                                               VolunteerView()) {
                                                   HStack(spacing: 5){
                                                       Image(uiImage: UIImage(named: "bullseye-arrow-thin")!)
                                                               .resizable()
                                                           .foregroundColor(Color.white)
                                                       .frame(width: 25, height: 25)
                                                       
                                                       Text("WEEKLY GOALS")
                                                           .font(.custom("muli", size: 18))
                                                           .frame(alignment:.leading)
                                                           .padding(.leading ,5)
                                                           .foregroundColor(Color.white)
                                                  Spacer()
                                                   }.padding()
                                               }
                                               
                                               NavigationLink(destination:
                                               VolunteerView()) {
                                                   HStack(spacing: 5){
                                                       Image(uiImage: UIImage(named: "fire-flame-thin")!)
                                                               .resizable()
                                                           .foregroundColor(Color.white)
                                                       .frame(width: 25, height: 25)
                                                       
                                                       Text("CREATE CHALLENGE")
                                                           .font(.custom("muli", size: 18))
                                                           .frame(alignment:.leading)
                                                           .padding(.leading ,5)
                                                           .foregroundColor(Color.white)
                                                  Spacer()
                                                   }.padding()
                                               }
                                               
                                               NavigationLink(destination:
                                               VolunteerView()) {
                                                   HStack(spacing: 5){
                                                       Image(uiImage: UIImage(named: "user-thin")!)
                                                               .resizable()
                                                           .foregroundColor(Color.white)
                                                       .frame(width: 25, height: 25)
                                                       
                                                       Text("FRIENDS")
                                                           .font(.custom("muli", size: 18))
                                                           .frame(alignment:.leading)
                                                           .padding(.leading ,5)
                                                           .foregroundColor(Color.white)
                                                  Spacer()
                                                   }.padding()
                                               }
                                             
                                               
                                               Button(action: {
                                                   UserDefaults.standard.removeObject(forKey: "sesion")
                                                   UserDefaults.standard.removeObject(forKey: "Token")
                                                   login.authenticated = 0
                                                   self.showBottomSheet.toggle()
                                                   
                                                   
                                               }) {
                                                   HStack(spacing: 5){
                                                       Image(uiImage: UIImage(named: "log-out-thin")!)
                                                               .resizable()
                                                           .foregroundColor(Color.white)
                                                       .frame(width: 25, height: 25)
                                                       
                                                       Text("LOG OUT")
                                                           .font(.custom("muli", size: 18))
                                                           .frame(alignment:.leading)
                                                           .padding(.leading ,5)
                                                           .foregroundColor(Color.white)
                                                  Spacer()
                                                   }.padding()
                                               }
                                               
                                           }
                                       }
                        
                        
                        
                    } //: ZStack
                    .frame(maxWidth: .infinity,
                           maxHeight: .infinity)
                    .background(Color.background)
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
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environmentObject(RoomViewModel())
    }
}
