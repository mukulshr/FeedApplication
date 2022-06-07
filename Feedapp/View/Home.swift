
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
                                .padding(.bottom, 150)
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
                                    }
                             
                                
                                FeedRoomView()
                                
                                  
                            } //: ScrollView
                        } //: VStack
                        
                        if isHeaderViewVisible {
                            ZStack(alignment: .bottom) {
                               HomeHeaderView()
//                                    .padding(.top, 60)
                               }
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 100)
                            .background(Color(UIColor.white))
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
                                               
                                               
                                               NavigationLink(destination: VolunteerView()) {
                                                   HStack{
                                                       Text("VOLUNTEER HOURS")
                                                           .frame(alignment:.leading)
                                                           .padding()
                                                           .foregroundColor(Color.white)
                                                           .frame(minWidth: 0, maxWidth: .infinity)
                                                  
                                                   }
                                                   .frame(alignment: .leading)
                                               }
                                               
                                               
                                               
                                               
                                               Button(action: {
                                                   
                                               }) {
                                                   HStack{
                                                       Text("CREATE STORY")
                                                           .padding()
                                                           .foregroundColor(Color.white)
                                                           .frame( alignment: .leading)
                                                           .frame(minWidth: 0, maxWidth: .infinity)
                                                   }
                                                   
                                               }
                                               .frame( alignment: .leading)
                                               
                                               Button(action: {
                                                   
                                               }) {
                                                   HStack{
                                                       Text("WEEKLY GOALS")
                                                           .padding()
                                                           .foregroundColor(Color.white)
                                                           .frame( alignment: .leading)
                                                           .frame(minWidth: 0, maxWidth: .infinity)
                                                   }
                                                   
                                               }
                                               .frame( alignment: .leading)
                                               Button(action: {
                                                   
                                               }) {
                                                   HStack{
                                                       Text("CREATE CHALLENGE")
                                                           .padding()
                                                           .foregroundColor(Color.white)
                                                           .frame( alignment: .leading)
                                                           .frame(minWidth: 0, maxWidth: .infinity)
                                                   }
                                                   
                                               }
                                               .frame( alignment: .leading)
                                               
                                               Button(action: {
                                                   UserDefaults.standard.removeObject(forKey: "sesion")
                                                   UserDefaults.standard.removeObject(forKey: "Token")
                                                   login.authenticated = 0
                                                   self.showBottomSheet.toggle()
                                                   
                                                   
                                               }) {
                                                   HStack{
                                                       Text("LOG OUT")
                                                           .padding()
                                                           .foregroundColor(Color.white)
                                                           .frame( alignment: .leading)
                                                           .frame(minWidth: 0, maxWidth: .infinity)
                                                   }
                                                   
                                               }
                                               .frame( alignment: .leading)
                                               
                                               
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
