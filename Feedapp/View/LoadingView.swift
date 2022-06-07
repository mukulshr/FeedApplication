//
//  LoadingView.swift
//  Feedapp
//
//  Created by Gagandeep on 05/06/22.
//

import SwiftUI


struct ActivityIndicator:View {
    
    @State private var isCircleRotating = true
    @State private var animateStart = false
    @State private var animateEnd = true
    
    var body: some View {
        
        ZStack {
//            Circle()
//                .stroke(lineWidth: 2)
////                .fill(Color.init(red: 0.96, green: 0.96, blue: 0.96))
//                .fill(Color.white)
//                .frame(width: 30, height: 30)
            
            Circle()
                .trim(from: animateStart ? 1/3 : 1/9, to: animateEnd ? 2/5 : 1)
                .stroke(lineWidth: 4)
                .rotationEffect(.degrees(isCircleRotating ? 0 : 360))
                .frame(width: 40, height: 40)
                .foregroundColor(Color.textYellow)
                .onAppear() {
                    withAnimation(Animation
                                    .linear(duration: 1)
                                    .repeatForever(autoreverses: false)) {
                        self.isCircleRotating.toggle()
                    }
                    withAnimation(Animation
                                    .linear(duration: 1)
                                    .delay(0.5)
                                    .repeatForever(autoreverses: true)) {
                        self.animateStart.toggle()
                    }
                    withAnimation(Animation
                                    .linear(duration: 1)
                                    .delay(1)
                                    .repeatForever(autoreverses: true)) {
                        self.animateEnd.toggle()
                    }
                }
        }
    }
}
