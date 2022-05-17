
import SwiftUI

struct SplashScreenView: View {
    @State var isActive : Bool = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    // Customise your SplashScreen here
    var body: some View {
        if isActive {
            Home()
        } else {
            ZStack {
                Image("app_page")
                                       .resizable()
                                       .scaledToFill()
                                       .edgesIgnoringSafeArea(.all)
                
                
               
                                   
                VStack() {
    //
                    Image(uiImage: #imageLiteral(resourceName: "godrej_logo_white"))
                        .resizable()
                        .frame(width: 170.0, height: 120.0)
                    Text("DoGood@Godrej").foregroundColor(.white).bold().font(.system(size: 24))
                    
               
                Spacer()
               
    //
                    Image(uiImage: #imageLiteral(resourceName: "logo_white"))
                        .resizable()
                        .frame(width: 55.0, height: 60.0)
                    Text("Powered by SuperHuman Race").foregroundColor(.white).bold().font(.system(size: 22))
                    
                }.padding()
                
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
