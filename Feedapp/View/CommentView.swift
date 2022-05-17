

import SwiftUI

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
    @ObservedObject var fetcher = deletecomment()
    @State var editmode = false
    @State var replymode = false
    @State var condtext: String = "Adding Comment"
    @State private var AuthToken = UserDefaults.standard.string(forKey: "Token")
    @State var showreplies: Bool = false
    @State private var isLoading = false

    @State var selectedid: Int = 0
    

    func conditiontext() {
    //need: String,needpostid: Int,needId:Int,id: Int
        print("this one")
        if (editmode == true ){
            condtext = "Editing Comment"
        }
        else if (replymode == true){
            editmode = false
        }
        else{
        condtext = "Adding Comment"
        }

    }

    
    func testFunction() {
        getcomments().getcomment(need: need,needpostid: needpostid,needId:needId) { (comments) in
            self.getcmnt = comments
            isLoading = false
//            print(comments)
        }
       }
  
    var body: some View {
       
        NavigationView {
            ZStack{
            
              
                
            Color.customGrey.ignoresSafeArea()
            VStack{
             
                
                if (isLoading ){
                    
                    Text("Loading...")
                    
                }
                
                
            if getcmnt != [] {
            ForEach(getcmnt, id: \.id) { cmnt in
//            ZStack(alignment: .bottom) {
                
                
                
                VStack(spacing:0){
                
                HStack(alignment: .bottom, spacing: 15) {
                    Image("profile_pic")
                              .resizable()
                              .frame(width: 40, height: 40, alignment: .center)
                              .cornerRadius(20)
                   
                    
                    VStack(alignment:.leading){
                    Text(cmnt.userName)
                            .frame(alignment:.leading)
                Text(cmnt.post_comment)
                            .frame(alignment:.leading)
                }.frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0,  alignment: .leading)
                    
                    .padding()
                        .foregroundColor(Color.white)
                        .background( Color.blue )
                        .cornerRadius(10)
                        
               
                }.frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0, maxHeight: 100, alignment: .leading)
                        .padding(.leading)
                        .padding(.trailing)
                    
                
                
                
                if (cmnt.mine == true){
                    HStack(){
                        Spacer()
                Button(
                    action: {
                        self.comment = cmnt.post_comment
                        editmode = true
                        conditiontext()
                        cmntId = cmnt.id
                      
                }, label: {
                    Text("Edit")
            })
                    Button(
                        action: {
                            isLoading = true
                                deletecomment().delete(need: comment,needpostid: needpostid,needId:needId,id: cmnt.id)
                            print("#",fetcher.delete)
                            self.testFunction()
                       
                    }, label: {
                        Text("Delete")
                })
                    }.padding(.trailing)
                }else{
                    HStack(){
                    Spacer()
                        if (cmnt.replyCount >= 1){
                            Button(
                                action: {
                                    showreplies.toggle()
                                    getcommentreplies().getcommentreply(needId: cmnt.id){ (replies) in
                                        self.getreply = replies
                                        print(self.getreply)
                                        self.selectedid = cmnt.id
                                    }
                                    print(AuthToken!)
                            }, label: {
                                Text("Reply \(cmnt.replyCount)")
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
                            replymode = true
                            conditiontext()
                            cmntId = cmnt.id
                            condtext = "Reply to \(cmnt.userName)"
                    }, label: {
                        Text("Reply")
                    }).padding(.trailing)
                }
                }
                
                    if showreplies{
                        if (cmnt.id == selectedid){
                        ForEach(getreply, id: \.id) { reply in
                            
                            
                            VStack(){
                            HStack( spacing: 10) {
                                Image("profile_pic")
                                          .resizable()
                                          .frame(width: 40, height: 40, alignment: .center)
                                          .cornerRadius(20)
                               
                                
                                VStack(alignment:.leading){
                                Text(reply.userName)
                                        .frame(alignment:.leading)
                                       
                                    Text(reply.comment_reply)
                                        .frame(alignment:.leading)
                                       
                            }.frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0,  alignment: .leading)
                            .padding()
                                        .foregroundColor(Color.white)
                                        .background( Color.blue )
                                        .cornerRadius(10)
                                        .padding()
                                    
                           
                            }
                            .frame(minWidth: 0,  maxWidth: .infinity, minHeight: 0, alignment: .trailing)
                                .padding(.leading,50)
                                
                            
                                if (reply.mine == true){
                                    HStack(){
                                        Spacer()
                                Button(
                                    action: {
//                                        self.comment = cmnt.post_comment
//                                        editmode = true
//                                        conditiontext()
//                                        cmntId = cmnt.id
                                      
                                }, label: {
                                    Text("Edit")
                            })
                                    Button(
                                        action: {
                                            
//                                                deletecomment().delete(need: comment,needpostid: needpostid,needId:needId,id: reply.id)
//                                            self.testFunction()
//                                            print(fetcher.delete)
                                       
                                    }, label: {
                                        Text("Delete")
                                })
                                    }.padding(.trailing)
                                }
                                
                            }
                        }
                        }
                    }
                    
            }
                
              
                
                
                
            }
                   
//                    } }
//                    .navigationBarTitle(Text("Navigation title"))
            }else if getcmnt == []{
                Text("Nothing There")
        }
            
            
//                    .navigationBarTitle(Text("Navigation title"))
            }
                
                
                
                
                
            }
        }.onAppear {
            self.testFunction()
        }
//        computedView()
        
       
        
        ZStack{
        VStack {
            HStack(){
                Text(condtext)
                    .animation(.easeInOut(duration: 1.0))
                    .font(Font.Nunito.bold(size: 16))
                    .foregroundColor(Color.customGrey)
                Spacer()
                Button(
                    action: {
                        if (editmode == true){
                            self.comment = ""
                                                   editmode = false
                            conditiontext()
                                               }
                        else  if (replymode == true){
                            self.comment = ""
                                                   editmode = false
                            replymode = false
                            conditiontext()
                                               }
                        else{
                                                   self.presentationMode.wrappedValue.dismiss()
                                               }
                        
                }, label: {
                    Text("Cancel")
            })
            }
            HStack(){
            TextField("Your Comment", text: $comment)
                .font(.title3)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.customGrey)
                .cornerRadius(50.0)
                .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)

                Button(
                    action: {
                        
                        if (editmode == true){
                            editcomment().edit(need: comment,needpostid: needpostid,needId:needId,id: cmntId)
                            self.testFunction()
                            self.comment = ""
                            editmode = false
                            conditiontext()
                            
                            
                        }else if (replymode == true){
                            if(self.comment.isEmpty ){
                                print("Please add comment")
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
                                                   }else {
                                                   addcomments().addcomment(need: comment,needpostid: needpostid,needId:needId)
                                               self.comment = ""
                                                       self.testFunction()
                                                   }
                                               }
                        
                       
                }, label: {
                Label("", systemImage: "plus")
            })
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
            .font(Font.Nunito.bold(size: 24))
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(21, antialiased: true)
            
            }}}
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 105, alignment: .trailing)
        .padding(.trailing, 15)
        .padding(.leading, 15)
    }
}


