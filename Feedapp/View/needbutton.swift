
import SwiftUI

struct SecondButton: View {
    @Binding var open: Bool
    
    var icon    = "pencil"
    var color   = Color.black
    var offsetX = 0
    var offsetY = 0
    var delay   = 0.0
    
    var body: some View {
        Button(action: {
            // do some action
        }) {
            Image(systemName: icon)
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .bold))
        }
        .padding()
        .background(color)
        .mask(Circle())
        .offset(x: open ? CGFloat(offsetX) : 0, y: open ? CGFloat(offsetY) : 0)
        .scaleEffect(open ? 1 : 0)
        .animation(Animation.spring(response: 0.2, dampingFraction: 0.5, blendDuration: 0).delay(Double(delay)))
    }

}
