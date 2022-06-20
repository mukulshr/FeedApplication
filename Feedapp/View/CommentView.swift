

import SwiftUI
import SDWebImageSwiftUI

struct CommentView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var getcmnt: [reqgetcmnt] = []
    @State var getreply: [reqreplies] = []
    @State var need : String = ""
    @State var needpostid : Int
    @State var needId : Int
    @State var comment: String = ""
    @State var delete: String = ""
    @State var cmntId : Int = 0
    @State var replyId : Int = 0
    @ObservedObject var fetcher = deletecomment()
    @State var editmode = false
    @State var editreplymode = false
    @State var replymode = false
    @State var condtext: String = "Adding Comment"
    @State private var AuthToken = UserDefaults.standard.string(forKey: "Token")
    @State var showreplies: Bool = false
    @State var IsLoaded: Bool = true

    @State var selectedid: Int = 0
    
    

    func conditiontext() {
    //need: String,needpostid: Int,needId:Int,id: Int
        print("this one")
        if (editmode == true ){
            condtext = "Editing Comment"
        }
        else if (replymode == true){
//            editmode = false
//            editreplymode = false
        }else if (editreplymode == true){
//            editmode = false
//            replymode = false
            condtext = "Editing Reply"
        }
        else{
        condtext = "Adding Comment"
        }

    }

    
    func testFunction() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    print("delay text done")
            getcomments().getcomment(need: need,needpostid: needpostid,needId:needId) { (comments) in
                self.getcmnt = comments
                self.IsLoaded = false
                showreplies = false
               
            }
        }
            
       
       }
    
    
   
  
    var body: some View {
       
//        NavigationView {
        VStack{
//                ScrollView {

//            ZStack{
            
              
                
//            Color.customGrey
//                VStack(spacing:10){
             
                
                
            if getcmnt != [] {
                ScrollView{
            ForEach(getcmnt, id: \.id) { cmnt in
//            ZStack(alignment: .bottom) {
                
                
                
                VStack(spacing:0){
                
                HStack(alignment: .bottom, spacing: 15) {
                    
                    AnimatedImage(url: URL(string: cmnt.profilePic))
                              .resizable()
                              .frame(width: 40, height: 40, alignment: .top)
                              .cornerRadius(20)
                              
                    
                    VStack(alignment:.leading){
                    Text(cmnt.userName)
                            .frame(alignment:.leading)
//                            .fontWeight(.bold)
                            .font(.custom("muli", size: 15))
                        Text(cmnt.created_at)
                                    .frame(alignment:.leading)
                                    .font(.custom("muli", size: 10))
                        
                Text(cmnt.post_comment)
                            .frame(alignment:.leading)
                            .font(.custom("muli", size: 15))
                }
                    .padding()
                 .frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0,  alignment: .leading)
                 .foregroundColor(Color.black)
                 .background( Color.white )
                        .cornerRadius(10)
                        
               
                }
                .padding(.horizontal)
                    
                
                
                
                if (cmnt.mine == true){
                    HStack(){
                        Spacer()
                        if (cmnt.replyCount >= 1){
//                            Button(
//                                action: {
//
//
//                            }, label: {
                                Text("\(cmnt.replyCount) Reply")
                                    .font(.custom("muli", size: 15))
                                    .foregroundColor(Color.black)
                                    .onTapGesture{
                                        getcommentreplies().getcommentreply(needId: cmnt.id){ (replies) in
                                            DispatchQueue.main.async {
                                            self.getreply = replies
                                            print(self.getreply)
                                            selectedid = cmnt.id
                                            showreplies.toggle()
                                            }
                                        }
                                        print(AuthToken!)
                                    }
//                            })
                        }
                        
                Button(
                    action: {
                        self.comment = cmnt.post_comment
                        replymode = false
                        editreplymode = false
                        editmode = true
                        
                        conditiontext()
                        cmntId = cmnt.id
                      
                }, label: {
                    Text("Edit")
            })                                    .font(.custom("muli", size: 15))
                            .foregroundColor(Color.black)

                    Button(
                        action: {
                            self.IsLoaded = true
                            deletecomment().delete(need: comment,needpostid: needpostid,needId:needId,id: cmnt.id)
                            
                            
                            print("#",fetcher.delete)
                            self.testFunction()
                       
                    }, label: {
                        Text("Delete")
                            .font(.custom("muli", size: 15))
                            .foregroundColor(Color.black)

                })
                    }.padding(.trailing)
                }else{
                    HStack(){
                    Spacer()
                        if (cmnt.replyCount >= 1){
                            Button(
                                action: {
                                    self.IsLoaded = true
                                    getcommentreplies().getcommentreply(needId: cmnt.id){ (replies) in
                                        DispatchQueue.main.async {
                                        self.getreply = replies
                                        print(self.getreply)
                                        selectedid = cmnt.id
                                        showreplies.toggle()
                                            self.IsLoaded = false
                                        }
                                    }
                                    print(AuthToken!)
                            }, label: {
                                Text("\(cmnt.replyCount) Reply")
                                    .font(.custom("muli", size: 15))
                                                  .foregroundColor(Color.black)
                            })
                        }
                    Button(
                        action: {
//                            self.comment = cmnt.post_comment
//                            editmode = true
//                            conditiontext()
//                            cmntId = cmnt.id
//
                            self.comment = ""
                            editmode = false
                            editreplymode = false
                            replymode = true
                            conditiontext()
                            cmntId = cmnt.id
                            condtext = "Reply to \(cmnt.userName)"
                    }, label: {
                        Text("Reply")
                            .font(.custom("muli", size: 15))
                                          .foregroundColor(Color.black)
                    }).padding(.trailing)
                }
                }
                
                    if showreplies{
                        if (cmnt.id == selectedid){
                        ForEach(getreply, id: \.id) { reply in
                            
                            
                            
                            LazyVStack(spacing:0){
                                HStack( spacing: 15) {
                                    
                                    AnimatedImage(url: URL(string: reply.profilePic))
                                              .resizable()
                                              .frame(width: 40, height: 40, alignment: .top)
                                              .cornerRadius(20)
                                              
                                    
                                    VStack(alignment:.leading){
                                    Text(reply.userName)
                                            .frame(alignment:.leading)
                //                            .fontWeight(.bold)
                                            .font(.custom("muli", size: 15))
                                        Text(reply.created_at)
                                                    .frame(alignment:.leading)
                                                    .font(.custom("muli", size: 10))
                                        
                                Text(reply.comment_reply)
                                            .frame(alignment:.leading)
                                            .font(.custom("muli", size: 15))
                                }
                                    .padding()
                                 .frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0,  alignment: .leading)
                                 .foregroundColor(Color.black)
                                 .background( Color.white )
                                        .cornerRadius(10)
                                        
                               
                                } .padding(.horizontal)
                                .frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0, alignment: .trailing)
                                .padding(.leading,50)
                                
                            
                                if (reply.mine == true){
                                    HStack(){
                                        Spacer()
                                Button(
                                    action: {
                                        self.comment = reply.comment_reply
                                         editmode = false
                                        replymode = false
                                        editreplymode = true
                                        conditiontext()
                                        replyId = reply.id
                                        print(reply.id,cmntId)
                                      
                                }, label: {
                                    Text("Edit")
                                    
                                        .font(.custom("muli", size: 15))
                                                      .foregroundColor(Color.black)
                            })
                                    Button(
                                        action: {
                                            self.IsLoaded = true
                                            replycomment().deletereplycomment(replyid: reply.id)
                                            self.testFunction()
                                       
                                       
                                    }, label: {
                                        Text("Delete")
                                            .font(.custom("muli", size: 15))
                                                          .foregroundColor(Color.black)
                                })
                                    }.padding(.trailing)
                                }
                                
                            }.padding(.vertical ,5)
                        }
                        }
                    }
                    
            }
                
              
                
                
                
            }
                
            }.background(Color.customGrey.edgesIgnoringSafeArea(.all))
//                    } }
//                    .navigationBarTitle(Text("Navigation title"))
            }else if getcmnt == []{
                
                

                VStack(alignment: .center){
                    
                    
                  
                    
                        Color.customGrey
                            .ignoresSafeArea()
                        Image("nodatafound")
                            .resizable()
                            .scaledToFit()
                            .padding(2)
                            .foregroundColor(Color.textYellow)
                    }

            }
                
            
//                    .navigationBarTitle(Text("Navigation title"))
//            }
//                .padding(.vertical ,20)
                
                
                
                
                
                   
                   if IsLoaded{
                       ActivityIndicator()
                           .frame(alignment: .center)
                   }
                   
                
//            }
//            .background(Color.customGrey.edgesIgnoringSafeArea(.all))
                   
//        }
//        }
       
        
        
       
        
//        ZStack{
        VStack {
            HStack(){
                Text(condtext)
                    .animation(.easeInOut(duration: 1.0))
                    .font(Font.Nunito.bold(size: 14))
                    .foregroundColor(Color.darkGrey)
                    .padding(.leading, 20)
                Spacer()
                Button(
                    action: {
                        self.IsLoaded = true

                        if (editmode == true){
                            self.comment = ""
                                                   editmode = false
                            editreplymode = false
                            conditiontext()
                            self.IsLoaded = false

                                               }
                        else    if (editreplymode == true){
                            self.comment = ""
                                                   editreplymode = false
                            conditiontext()
                            self.IsLoaded = false
                            replyId = 0

                                               }
                        else  if (replymode == true){
                            self.comment = ""
                                                   editmode = false
                            editreplymode = false
                            replymode = false
                            conditiontext()
                            self.IsLoaded = false
                                               }
                        else{
                            if self.comment == ""{
                            self.IsLoaded = false
                                                   self.presentationMode.wrappedValue.dismiss()
                            }else{
                                
                                self.comment = ""
                                self.IsLoaded = false
                            }
                                               }
                        
                }, label: {
                    Text("Cancel")
                        .font(Font.Nunito.bold(size: 14))
                        .foregroundColor(Color.darkGrey)
            }).padding(.trailing, 70)
            }
            HStack(){
            TextField("Write a Comment...", text: $comment)
                .font(.title3)
                .padding(.vertical,10)
                .padding(.horizontal,15)
                .frame(maxWidth: .infinity)
                .background(Color.customGrey)
                .cornerRadius(50.0)
                .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)

                Button(
                    action: {
                        self.IsLoaded = true

                        
                        if (editmode == true){
                            editcomment().edit(need: comment,needpostid: needpostid,needId:needId,id: cmntId)
                            self.testFunction()
                            self.comment = ""
                            editmode = false
                            conditiontext()
                            
                            
                        } else  if (editreplymode == true){
                            replycomment().editreplycomment(replyid: replyId, reply: comment)
                            self.testFunction()
                            self.comment = ""
                            replyId = 0
                            editreplymode = false
                            conditiontext()
                            
                            
                            
                        }
                        else if (replymode == true){
                            if(self.comment.isEmpty ){
                                print("Please add comment")
                                self.IsLoaded = false

                            }else {
                                replycomment().replycomment(commentid: cmntId, reply: comment)
                                self.testFunction()
//                                (comment,needpostid,cmntId)
                        self.comment = ""
                            }
                        }
                        else{
                                                   if(self.comment.isEmpty ){
                                                       print("Please add comment")
                                                       self.IsLoaded = false

                                                   }else {
                                                   addcomments().addcomment(need: comment,needpostid: needpostid,needId:needId)
                                               self.comment = ""
                                                       self.testFunction()
                                                   }
                                               }
                        
                       
                }, label: {
                    Image(uiImage: UIImage(named: "paper-plane")!)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .padding(3)
                                .foregroundColor(.white)
                })
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
            .font(Font.Nunito.bold(size: 24))
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(50)
            
            }
            
        }.padding(.bottom ,5)
            
//        }
//        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .trailing)
//        .padding(.trailing, 15)
//        .padding(.leading, 15)
    }.navigationBarTitle(need)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                self.testFunction()
            }
            
            
    }
}



