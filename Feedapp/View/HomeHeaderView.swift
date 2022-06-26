

import SwiftUI
import SDWebImageSwiftUI


struct HomeHeaderView: View {
    
    @EnvironmentObject var login: PostViewModel
    @State private var open = false
    @State private var showingAlert = false
    @State private var isPresentedCamera = false
    @State private var isPresentedLibrary = false
    @AppStorage("feedFlag") var flag: String = ""
    
    @AppStorage("id") var userloginID: String = ""
    
    @Binding var isPresented: Bool
   
    @AppStorage("id") var userID: String = ""
    @AppStorage("Profile_pic") var ProfilePic: String = ""
    @AppStorage("Company_pic") var CompanyPic: String = ""
   
    var body: some View {
       
        HStack(alignment: .center) {
         
            HStack{
                if(userloginID.count == 0){
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
                          
                      }else  {



//                          Button(action: {
//                              self.open.toggle()
//                          }) {

                                  AnimatedImage(url: URL(string: CompanyPic ?? "https://i.pinimg.com/originals/d9/56/9b/d9569bbed4393e2ceb1af7ba64fdf86a.jpg"))
                                  .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .clipShape(Circle())
                                           


                              .onTapGesture {
                                  
                                  if (flag == "PUB") {
                                      UserDefaults.standard.set("PVT", forKey: "feedFlag")
                                  }else{
                                  
                                      isPresented = true
                                  }
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
                        if(userloginID.count == 0){
                        
                        
                    
                        Image.profile_pic
                                .resizable()
//                                          .aspectRatio(contentMode: .fit)
                                          .clipShape(Circle())
                                          .overlay(Circle().stroke(Color.black, lineWidth: 1))
                            
                   
                   
                        }else {
                            AnimatedImage(url: URL(string: ProfilePic))
                                .resizable()
//                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.black, lineWidth: 1))
                                
                        }
                    }
                    
                   
//                    .padding()
//                    .background(Color.white)
                    .zIndex(1)
                    
//                              .aspectRatio(contentMode: .fit)
//                              .clipShape(Circle())
                    
                    
                    
                    SecondButton(open: $open, icon: "hand-heart-thin", color: .black, offsetX: -90,endpoint: "volunteer")
                    
                    SecondButton(open: $open, icon: "box-heart-thin", color: .black, offsetX: -60, offsetY: 60, delay: 0.2,endpoint: "story")
                    SecondButton(open: $open, icon:"envira-brands", color: .black, offsetX: 90, delay: 0.4,endpoint:"create")
                    SecondButton(open: $open, icon:"hand-holding-box-thin" , color: .black, offsetX: 60, offsetY: 60, delay: 0.6,endpoint: "donate")
                    
                    
                    if(userloginID.count == 0){
                        
                        SecondButton(open: $open, icon: "palette-thin", color: .black,  offsetX: 0, offsetY: 90, delay: 0.8,endpoint: "covid-19-support")
                        
                    }else{
                    
                    
                        SecondButton(open: $open, icon:  "camera-thin", color: .black, offsetX: 0, offsetY: 90, delay: 0.8)
                        .onTapGesture {
                            showingAlert = true
                        }
                        .alert("Change Profile", isPresented: $showingAlert) {
                            
                            Button("Camera") { isPresentedCamera.toggle() }
                            Button("Photo Library") {isPresentedLibrary.toggle() }
                            Button("Close", role: .cancel) { self.open.toggle() }
                        }
                    }
                    
                    
                    
                    
                }

            }.frame(alignment: .center)
                .frame(maxWidth: .infinity)
                
                
                
               
       
            
            
            
            HStack(){
                Spacer()
                Image(uiImage: UIImage(named: "bell-thin")!)
                        .resizable()
                    .frame(width: 20, height: 25)

                
                
            }
            .padding(.trailing, 30)
                .frame(alignment: .trailing)
                .frame(maxWidth: .infinity)
         
           
        }.fullScreenCover(isPresented: $isPresentedCamera, content: FullModalCameraView.init)
            .fullScreenCover(isPresented: $isPresentedLibrary, content: ModalPhotoLibraryView.init)
            
        .frame(maxWidth: .infinity)
        .frame(minHeight: 40,  maxHeight: 60)

//        .padding(.horizontal)
            .padding(.vertical,10)
            .background(Color.white).ignoresSafeArea(.all, edges: .top)

        
            }

}

//struct HomeHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeHeaderView()
//            .previewLayout(.sizeThatFits)
//    }
//}


struct FullModalCameraView: View {
    @Environment(\.presentationMode) var presentationMode


        
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    
    
    func aa () -> String{
        let imageData: Data? = image.jpegData(compressionQuality: 0.4)
        let imageStr = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
        return imageStr
        
    }
        
            
           
            
            var body: some View {
                
                
                VStack {
                
                    
                 
                    
                    
                    if self.image.size.width != 0{
                        
                          Image(uiImage: self.image)
                              .resizable()
                              .scaledToFill()
                              .frame(minWidth: 0, maxWidth: .infinity)
                              .edgesIgnoringSafeArea(.all)
                          
                    Button(action: {
                        HeaderViewModel().upload_pic(imagecode:aa(),onSuccess: { presentationMode.wrappedValue.dismiss()},onFailure:{  presentationMode.wrappedValue.dismiss()})
                        presentationMode.wrappedValue.dismiss()
//                       print(aa())
                    }){
                        HStack {
                            Image(systemName: "photo")
                                .font(.system(size: 20))
                                
                            Text("Upload")
                                .font(.headline)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .padding(.horizontal)}
                    
                        
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }){
                            HStack {
                                Image(systemName: "xmark.square.fill")
                                    .font(.system(size: 20))
                                    
                                Text("Cancel")
                                    .font(.headline)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .padding(.bottom)
                            .padding(.horizontal)}
                        
                        
                    }else{
                    
                        Button(action: {
                            self.isShowPhotoLibrary = true
                        }){
                            HStack {
                                Image(systemName: "photo")
                                    .font(.system(size: 20))
                                    
                                Text("Camera")
                                    .font(.headline)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .padding(.horizontal)}
                        
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }){
                        HStack {
                            Image(systemName: "xmark.square.fill")
                                .font(.system(size: 20))
                                
                            Text("Cancel")
                                .font(.headline)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .padding(.horizontal)}
                    }
                    

            }.onAppear{ self.isShowPhotoLibrary = true}
                .sheet(isPresented: $isShowPhotoLibrary) {
                    ImagePicker(sourceType: .camera, selectedImage: self.$image)
                }
            }
}





struct ModalPhotoLibraryView: View {
    @Environment(\.presentationMode) var presentationMode


        
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    
    
    func aa () -> String{
        let imageData: Data? = image.jpegData(compressionQuality: 0.4)
        let imageStr = imageData?.base64EncodedString(options: .lineLength64Characters) ?? ""
        return imageStr
        
    }
        
            
           
            
            var body: some View {
                
                
                VStack {
                
                    
                 
                    
                    
                    if self.image.size.width != 0{
                        
                          Image(uiImage: self.image)
                              .resizable()
                              .scaledToFill()
                              .frame(minWidth: 0, maxWidth: .infinity)
                              .edgesIgnoringSafeArea(.all)
                              .clipShape(Circle())
                              .overlay(Circle().stroke(Color.white ,lineWidth:5.0))
                              .shadow(radius: 10)
                          
                    Button(action: {
                        HeaderViewModel().upload_pic(imagecode:aa(),onSuccess: {  presentationMode.wrappedValue.dismiss()},onFailure:{  presentationMode.wrappedValue.dismiss()})
                        presentationMode.wrappedValue.dismiss()
                    }){
                        HStack {
                            Image(systemName: "photo")
                                .font(.system(size: 20))
                                
                            Text("Upload")
                                .font(.headline)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .padding(.horizontal)}
                    
                        
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }){
                            HStack {
                                Image(systemName: "xmark.square.fill")
                                    .font(.system(size: 20))
                                    
                                Text("Cancel")
                                    .font(.headline)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .padding(.bottom)
                            .padding(.horizontal)}
                        
                        
                    }else{
                    
                        Button(action: {
                            self.isShowPhotoLibrary = true
                        }){
                            HStack {
                                Image(systemName: "photo")
                                    .font(.system(size: 20))
                                    
                                Text("Photo Library")
                                    .font(.headline)
                            }
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .padding(.horizontal)}
                        
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }){
                        HStack {
                            Image(systemName: "xmark.square.fill")
                                .font(.system(size: 20))
                                
                            Text("Cancel")
                                .font(.headline)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                        .background(Color.black)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .padding(.horizontal)}
                    }
                    

            }.onAppear{ self.isShowPhotoLibrary = true}
                .sheet(isPresented: $isShowPhotoLibrary) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                }
            }
}
