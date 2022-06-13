
import SwiftUI

struct SplashScreenView: View {
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
//    let flag = UserDefaults.standard.string(forKey: "feedFlag");
    
    // Customise your SplashScreen here
    var body: some View {
        if isActive {
            Home()
        } else {
//            ZStack {
//                Image("app_page")
//                                       .resizable()
//                                       .scaledToFill()
//                                       .edgesIgnoringSafeArea(.all)
//
//
               
                                   
                VStack() {
    
                    VStack{
                    Image(uiImage: #imageLiteral(resourceName: "godrej_logo_white"))
                        .resizable()
                        .frame(width: UIScreen.screenWidth * 0.4, height: UIScreen.screenHeight * 0.15)
                    Text("DoGood@Godrej").foregroundColor(.white).bold().font(.system(size: 24))
                    }
                    .padding(.top ,UIScreen.screenHeight * 0.05)
                    
               
                Spacer()
               
    
                    VStack{
                    Image(uiImage: #imageLiteral(resourceName: "logo_white"))
                        .resizable()
                        .frame(width: UIScreen.screenWidth * 0.15, height: UIScreen.screenHeight * 0.075)
                        Text("Powered by SuperHuman Race").foregroundColor(.white).bold().font(.system(size: UIScreen.screenWidth * 0.05))
                    }
                    .padding(.bottom ,UIScreen.screenHeight * 0.05)
                    
//                }
                
            }
            .onAppear {
                if UserDefaults.standard.object(forKey: "feedFlag") != nil{
                    print("kuch to hai")
                    print(UserDefaults.standard.string(forKey: "feedFlag")!)
                }else{
                    print("set krdiya hai")
                    UserDefaults.standard.set("PUB", forKey: "feedFlag")
                }
                
                
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                    
                    
                }
            }.frame( maxWidth: .infinity,maxHeight: UIScreen.screenHeight)
                .ignoresSafeArea()
            .background(
                Image("app_page")
                        .resizable()
                        .ignoresSafeArea()
                )
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
