
import SwiftUI

struct Login: View {
    @State private var email = ""
    @State private var password = ""
    
    @EnvironmentObject var login: PostViewModel
    var body: some View {
        ZStack{
            Image("app_page")
                                   .resizable()
                                   .scaledToFill()
                                   .edgesIgnoringSafeArea(.all)
            
            
           
                               
            VStack {
//
                Image(uiImage: #imageLiteral(resourceName: "godrej_logo_white"))
                    .resizable()
                    .frame(width: 170.0, height: 120.0)
                Text("DoGood@Godrej").foregroundColor(.white).bold()
                    
                            VStack {
                               
                                
                
               
                TextField("Email", text: $email)
                    .font(.title3)
                                           .padding()
                                           .frame(maxWidth: .infinity)
                                           .background(Color.white)
                                           .cornerRadius(50.0)
                                           .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
                    .keyboardType(.emailAddress)
              
                SecureField("Password", text: $password)
                    .font(.title3)
                                           .padding()
                                           .frame(maxWidth: .infinity)
                                           .background(Color.white)
                                           .cornerRadius(50.0)
                                           .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
                   //                        .padding(.vertical)
                Button(action:{
                    login.login(email: email, password: password)
                }){
                    Text("SIGN IN TO SAVE THE WORLD").foregroundColor(.green).bold()
                }.padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white)
                                    .cornerRadius(50.0)
                                    .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
                                Spacer()
            }.padding()
            }.padding()
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
