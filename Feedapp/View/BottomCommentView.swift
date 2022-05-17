
import SwiftUI

struct BottomCommentView: View {
    @State private var comment: String = "User"
    var body: some View {
        ZStack{
        VStack {
            HStack(){
                Text("Adding Comment")
                    .font(Font.Nunito.bold(size: 16))
                    .foregroundColor(Color.customGrey)
                Spacer()
                NavigationLink(destination: ContentView()) {
                    Text("Cancel")
                }
            }
            HStack(){
            TextField("Your Comment", text: $comment)
                .font(.title3)
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.customGrey)
                .cornerRadius(50.0)
                .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)

                Button(action: {}, label: {
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

struct BottomCommentView_Previews: PreviewProvider {
    static var previews: some View {
        BottomCommentView()
            .previewLayout(.sizeThatFits)
    }
}
