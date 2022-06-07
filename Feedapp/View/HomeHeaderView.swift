

import SwiftUI
import SDWebImageSwiftUI


struct HomeHeaderView: View {
    
    @EnvironmentObject var login: PostViewModel
    @State private var ProfilePic = UserDefaults.standard.string(forKey: "Profile_pic")
    @State private var CompanyPic = UserDefaults.standard.string(forKey: "Company_pic")
    @State private var open = false
    
    
  
   
    var body: some View {
       
        HStack(alignment: .center) {
         
            HStack{
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
                          )
                          
                      }else if login.authenticated == 1 {



                          Button(action: {
                              self.open.toggle()
                          }) {

                                  AnimatedImage(url: URL(string: CompanyPic ?? "https://i.pinimg.com/originals/d9/56/9b/d9569bbed4393e2ceb1af7ba64fdf86a.jpg"))
                                  .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color.black, lineWidth: 2))



                              }
//

                          }
                Spacer()


            }
            .padding(.leading, 20)
            .frame(alignment: .leading)
                .frame(maxWidth: .infinity)

                          
                    
                         
                      
          

            Spacer()
            
      
            HStack(alignment: .center){
                ZStack {
                    
                    Button(action: {
                        self.open.toggle()
                    }) {
                        if login.authenticated == 0 {
                        
                        
                    
                        Image.profile_pic
                                .resizable()
                                          .aspectRatio(contentMode: .fit)
                                          .clipShape(Circle())
                                          .overlay(Circle().stroke(Color.black, lineWidth: 2))
                   
                   
                        }else if login.authenticated == 1 {
                            AnimatedImage(url: URL(string: ProfilePic ?? "https://i.pinimg.com/originals/d9/56/9b/d9569bbed4393e2ceb1af7ba64fdf86a.jpg"))
                                .resizable()
                                .frame(width: 40, height: 40)
                                .cornerRadius(20)
                                
                        }
                    }
                    
                   
//                    .padding()
//                    .background(Color.white)
                    .zIndex(1)
                    
//                              .aspectRatio(contentMode: .fit)
//                              .clipShape(Circle())
                    
                    
                    NavigationLink(destination: VolunteerView()) {
                    SecondButton(open: $open, icon: "bubble.left.fill", color: .black, offsetX: -90)
                    }
                    SecondButton(open: $open, icon: "trash", color: .black, offsetX: -60, offsetY: 60, delay: 0.2)
                    SecondButton(open: $open, icon: "pencil", color: .black, offsetX: 90, delay: 0.4)
                    SecondButton(open: $open, icon: "folder", color: .black, offsetX: 60, offsetY: 60, delay: 0.6)
                    SecondButton(open: $open, icon: "person", color: .black, offsetX: 0, offsetY: 90, delay: 0.8)
                }

            }.frame(alignment: .center)
                .frame(maxWidth: .infinity)
                
                
                
               
       
            
            
            
            HStack(){
                Spacer()
                Image(uiImage: UIImage(named: "bell-thin")!)
                        .resizable()
                    .frame(width: 30, height: 35)

                
                
            }
            .padding(.trailing, 20)
                .frame(alignment: .trailing)
                .frame(maxWidth: .infinity)
         
           
        }
        .frame(maxWidth: .infinity)
        .frame(minHeight: 40,  maxHeight: 60)

//        .padding(.horizontal)
            .padding(.vertical,10)
            .background(Color.white).ignoresSafeArea(.all, edges: .top)

        
            }
}

struct HomeHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HomeHeaderView()
            .previewLayout(.sizeThatFits)
    }
}


