
import SwiftUI

struct Login: View {
    @State private var email = ""
    @State private var password = ""
    @State private var showingModal = false
    @State private var stringOfTextField: String = String()
    
    @EnvironmentObject var login: PostViewModel
    var body: some View {
        ZStack{
        VStack() {

            VStack{
            Image(uiImage: #imageLiteral(resourceName: "godrej_logo_white"))
                .resizable()
                .frame(width: UIScreen.screenWidth * 0.30, height: UIScreen.screenHeight * 0.15)
            Text("DoGood@Godrej").foregroundColor(.white).bold().font(.custom("muli",size: 20))
                    .padding(.top ,-30)
            }
            .padding(.top ,-UIScreen.screenHeight * 0.05)
            
       
            VStack {
    
TextField("Email", text: $email)
    .font(.title3)
    .padding(UIScreen.screenHeight * 0.02)
    .frame(width: UIScreen.screenWidth * 0.85)
                           .background(Color.white)
                           .cornerRadius(50.0)
                           .shadow(color: Color.black.opacity(0.08), radius: 60)
    .keyboardType(.emailAddress)

SecureField("Password", text: $password)
    .font(.title3)
    .padding(UIScreen.screenHeight * 0.02)
                           .frame(width: UIScreen.screenWidth * 0.85)
                           .background(Color.white)
                           .cornerRadius(50.0)
                           .shadow(color: Color.black.opacity(0.08), radius: 60)
Button(action:{
    login.login(email: email, password: password)
}){
    Text("SIGN IN TO SAVE THE WORLD").foregroundColor(.green).bold()
}.padding(UIScreen.screenHeight * 0.02)
//                    .frame(maxWidth: .infinity)
                    .frame(width: UIScreen.screenWidth * 0.85)
                    .background(Color.white)
                    .cornerRadius(50.0)
                    .shadow(color: Color.black.opacity(0.08), radius: 60)
//                Spacer()
                Text("Forgot Password ?").foregroundColor(.white).bold().font(.custom("muli", size: 16))
                    .onTapGesture{self.showingModal = true}
                
                
                

                    
                
                
                HStack(spacing:40){
                ZStack {
                        
                    Image("google-brands")
                        .resizable()
                        .frame(width: 25, height: 30)
                        .padding(.vertical ,10)
                        .padding(.horizontal ,15)
                        .background(.white)
                        .cornerRadius(15)
                        .foregroundColor(Color.godrejgreen)

                        
                        }
                
                    ZStack {
                            
                        Image("apple-brands")
                            .resizable()
                            .frame(width: 25, height: 30)
                            .padding(.vertical ,10)
                            .padding(.horizontal ,15)
                            .background(.white)
                            .cornerRadius(15)
                            .foregroundColor(Color.godrejgreen)

                            
                            }
                    
                    ZStack {
                            
                        Image("facebook-brands")
                            .resizable()
                            .frame(width: 25, height: 30)
                            .padding(.vertical ,10)
                            .padding(.horizontal ,15)
                            .background(.white)
                            .cornerRadius(15)
                            .foregroundColor(Color.godrejgreen)

                            
                            }
                    
                }.padding(.vertical ,-5)
                
                
                
                
                Text("Not superhuman yet ?").foregroundColor(.white).bold().font(.custom("muli", size: UIScreen.screenWidth * 0.05))
                NavigationLink(destination: SignUp()) {
                Text("Sign-up today").foregroundColor(.white).bold().font(.custom("muli", size: 24))
                }
                Spacer()
}
//            .padding()

       

            VStack(alignment: .center){
            Image(uiImage: #imageLiteral(resourceName: "logo_white"))
                .resizable()
                .frame(width: 40, height: 45)
                Text("Powered by SuperHuman Race").foregroundColor(.white).bold().font(.custom("muli", size: UIScreen.screenWidth * 0.05))
                    .padding(.top , -10)
                    .padding(.bottom ,UIScreen.screenHeight * 0.1)
            }
           
            
//                }
            
        
    }.frame( maxWidth: .infinity)
//            .ignoresSafeArea()
        .background(
            Image("app_page")
                    .resizable()
                    .ignoresSafeArea()
                    .aspectRatio(contentMode: .fill)
            )
            
            
            
            if $showingModal.wrappedValue {
                            // But it will not show unless this variable is true
                            ZStack {
                                Color.black.opacity(0.4)
                                    .edgesIgnoringSafeArea(.vertical)
                                    .onTapGesture{self.showingModal = false}
                                // This VStack is the popup
                                VStack(spacing:0.5) {
                                    HStack{
                                    Text("Forgot Password")
                                            .padding(.horizontal)
                                        .foregroundColor(Color.black)
                                        Spacer()
                                    }
                                    
                                    
                                    
                                    TextField("Enter Email ID", text: $stringOfTextField)
                                               .padding()
                                               .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.darkGrey, style: StrokeStyle(lineWidth: 1.0)))
                                               .padding()
                                    
                                    
                                    HStack{
                                    Spacer()
                                    Text("SUBMIT")
                                            .foregroundColor(Color.white)
                                        .padding(10)
                                        .background(Color.black)
                                        .cornerRadius(5)
                                        .padding(.horizontal)
                                        .onTapGesture{self.showingModal = false}
                                    }
                                    
                                  
                                    
                                }
                                .frame(width: UIScreen.screenWidth * 0.85, height: 200)
                                .background(Color.white)
                                .cornerRadius(20).shadow(radius: 20)
                            }
            }
                    
    }
}
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}

