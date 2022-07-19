//
//  SignUp.swift
//  Feedapp
//
//  Created by Gagandeep on 19/06/22.
//

import SwiftUI
import AlertToast

struct SignUp: View {
    @State private var first_Name = ""
    @State private var last_Name = ""
    @State private var email = ""
    @State private var phone_no = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var showphoneAlert = false
    @State private var stringOfTextField: String = String()
    
    
    @State var y : CGFloat = 150
    @State var countryCode = ""
    @State var countryFlag = ""
    
    
    
    
    
    
    
    
    
    func getIPAddress() -> String {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>? = nil
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }
                
                guard let interface = ptr?.pointee else { return "" }
                let addrFamily = interface.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    
                    // wifi = ["en0"]
                    // wired = ["en2", "en3", "en4"]
                    // cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]
                    
                    let name: String = String(cString: (interface.ifa_name))
                    if  name == "en0" || name == "en2" || name == "en3" || name == "en4" || name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        return address ?? ""
    }
    
    
    
    @EnvironmentObject var login: PostViewModel
    var body: some View {
        ZStack{
            VStack() {
                
                //            VStack{
                //            Image(uiImage: #imageLiteral(resourceName: "godrej_logo_white"))
                //                .resizable()
                //                .frame(width: UIScreen.screenWidth * 0.30, height: UIScreen.screenHeight * 0.15)
                //            Text("DoGood@Godrej").foregroundColor(.white).bold().font(.custom("Muli-regular",size: 20))
                //                    .padding(.top ,-30)
                //            }
                //            .padding(.top ,-UIScreen.screenHeight * 0.05)
                //
                
                VStack {
                    
                    TextField("First Name", text: $first_Name)
                        .font(.title3)
                        .padding(UIScreen.screenHeight * 0.02)
                        .frame(width: UIScreen.screenWidth * 0.85)
                        .background(Color.white)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 60)
                    
                    
                    TextField("Last Name", text: $last_Name)
                        .font(.title3)
                        .padding(UIScreen.screenHeight * 0.02)
                        .frame(width: UIScreen.screenWidth * 0.85)
                        .background(Color.white)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 60)
                    
                    TextField("Email Address", text: $email)
                        .font(.title3)
                        .padding(UIScreen.screenHeight * 0.02)
                        .frame(width: UIScreen.screenWidth * 0.85)
                        .background(Color.white)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 60)
                        .keyboardType(.emailAddress)
                    
                    
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 50).stroke()
                            .frame(width: UIScreen.screenWidth * 0.85,height: 50)
                            .background(Color.white)
                            .cornerRadius(50)
                        
                        
                        HStack (spacing: 0) {
                            Text(countryCode.isEmpty ? "🇮🇳 +91" : "\(countryFlag) +\(countryCode)")
                                .frame(width: 80, height: 50)
                                .background(Color.secondary.opacity(0.2))
                                .cornerRadius(50)
                                .foregroundColor(countryCode.isEmpty ? .secondary : .black)
                                .onTapGesture {
                                    withAnimation (.spring()) {
                                        self.y = 0
                                    }
                                }
                            TextField("Phone Number", text: $phone_no)
//                                .padding()
                                .cornerRadius(50.0)
                                .frame(width: 200, height: 50)
                                .keyboardType(.phonePad)
                        }
                        .cornerRadius(50)
                        
                        CountryCodes(countryCode: $countryCode, countryFlag: $countryFlag, y: $y)
                            .offset(y: y)
                            .zIndex(10)
                        
                        
                    }.zIndex(1)
                    
                    SecureField("Password", text: $password)
                        .font(.title3)
                        .padding(UIScreen.screenHeight * 0.02)
                        .frame(width: UIScreen.screenWidth * 0.85)
                        .background(Color.white)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 60)
                    
                    Text("I accept these Terms & Conditions").foregroundColor(.white).bold().font(.custom("Muli-regular", size: 16))
                    //                    .onTapGesture{}
                    
                    Button(action:{
                        
                        if (first_Name == "" || last_Name == "" || email == "" || phone_no == "" || password == "") {
                            showAlert.toggle()
                        }else if (phone_no.count <= 4){
                            showphoneAlert.toggle()
                            print("Please Enter Valid Phone Number")
                            
                        }else{
                            print(getIPAddress())
                            print(phone_no)
                            print(countryCode)
                            login.signup(f_name: first_Name, l_name: last_Name, email: email, password: password, countrycode: countryCode, contactno: phone_no, ipaddress: getIPAddress())
                            print("DONE DONE")
                            
                        }
                        
                        
                        //    login.login(email: email, password: password)
                    }){
                        Text("All done! Take me home").foregroundColor(.green).bold()
                    }.padding(UIScreen.screenHeight * 0.02)
                    //                    .frame(maxWidth: .infinity)
                        .frame(width: UIScreen.screenWidth * 0.85)
                        .background(Color.white)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 60)
                        .toast(isPresenting: $showAlert){
                            
                            
                            AlertToast(displayMode: .hud, type: .regular, title: "Please Fill All Fields")
                            
                        }
                        .toast(isPresenting: $showphoneAlert){
                            
                            
                            AlertToast(displayMode: .hud, type: .regular, title: " Enter A Valid Number")
                            
                        }
                    //                Spacer()
                    
                    
                    
                    
                    Spacer()
                }
                
                
                
                VStack(alignment: .center){
                    Image(uiImage: #imageLiteral(resourceName: "logo_white"))
                        .resizable()
                        .frame(width: 40, height: 45)
                    Text("Powered by SuperHuman Race").foregroundColor(.white).bold().font(.custom("Muli-regular", size: UIScreen.screenWidth * 0.05))
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
            
            
            
        }
    }
}


















struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}



