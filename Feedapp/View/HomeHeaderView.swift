

import SwiftUI
import SDWebImageSwiftUI

struct HomeHeaderView: View {
    
    @EnvironmentObject var login: PostViewModel
    @State private var ProfilePic = UserDefaults.standard.string(forKey: "Profile_pic")
    @State private var CompanyPic = UserDefaults.standard.string(forKey: "Company_pic")
    @State private var open = false
    
    
  
   
    var body: some View {
        HStack() {
           
            if login.authenticated == 0 {
                NavigationLink(destination: Login()) {
                    Text("LOGIN")
                }.navigationBarTitle(Text(" "))

                          .frame(width: 60, height: 10)

                          .font(.system(size: 18))
                          .padding()
                          .foregroundColor(.red)
                          .overlay(
                              RoundedRectangle(cornerRadius: 10)
                                  .stroke(Color.red, lineWidth: 1)
                          ).padding(.leading, 20)
                      }else if login.authenticated == 1 {
//                       Text("Logged In")
                          AnimatedImage(url: URL(string: CompanyPic ?? "https://i.pinimg.com/originals/d9/56/9b/d9569bbed4393e2ceb1af7ba64fdf86a.jpg"))
                              .resizable()
                              .frame(width: 40, height: 40)
                              .cornerRadius(20)
                      }
          
//
            Spacer()
            
      
                
                ZStack {
                    
                    Button(action: {
                        self.open.toggle()
                    }) {
                        if login.authenticated == 0 {
                        
                        
                    
                        Image.profile_pic
                            .resizable()
                            .frame(width: 40, height: 40)
                            .cornerRadius(20)
                   
                   
                        }else if login.authenticated == 1 {
                            AnimatedImage(url: URL(string: ProfilePic ?? "https://i.pinimg.com/originals/d9/56/9b/d9569bbed4393e2ceb1af7ba64fdf86a.jpg"))
                                .resizable()
                                .frame(width: 40, height: 40)
                                .cornerRadius(20)
                                
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .border(.black)
                    .zIndex(10)
                    
                    
                    NavigationLink(destination: VolunteerView()) {
                    SecondButton(open: $open, icon: "bubble.left.fill", color: .blue, offsetX: -90)
                    }
                    SecondButton(open: $open, icon: "trash", color: .green, offsetX: -60, offsetY: 60, delay: 0.2)
                    SecondButton(open: $open, icon: "pencil", color: .purple, offsetX: 90, delay: 0.4)
                    SecondButton(open: $open, icon: "folder", color: .orange, offsetX: 60, offsetY: 60, delay: 0.6)
                    SecondButton(open: $open, icon: "person", color: .red, offsetX: 0, offsetY: 90, delay: 0.8)
                }
                
                
                
               
                
            
            Spacer()
            Image.notificationBell
                .padding(.trailing, 20)
           
        }.frame(height:100)
            .background(Color.white)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                   alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }
}

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView()
            .previewLayout(.sizeThatFits)
    }
}
