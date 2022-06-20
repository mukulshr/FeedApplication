
import SwiftUI

struct SecondButton: View {
    @Binding var open: Bool
    
    var icon    = "pencil"
    var color   = Color.black
    var offsetX = 0
    var offsetY = 0
    var delay   = 0.0
    var endpoint = ""
    
    var body: some View {
        NavigationLink(destination: GlobalView(endpoint: endpoint)) {
            Image(uiImage: UIImage(named: icon) ?? UIImage(named: "hand-heart-thin")!).resizable()
                .foregroundColor(.white)
//                .resizable()
                .frame(width: 20, height: 20)
        }
        .padding()
        .background(color)
        .mask(Circle())
        .offset(x: open ? CGFloat(offsetX) : 0, y: open ? CGFloat(offsetY) : 0)
        .scaleEffect(open ? 1 : 0)
        .animation(Animation.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0).delay(Double(delay)))
    }

}
