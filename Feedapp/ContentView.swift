//
//  ContentView.swift
//  JSON
//
//  Created by Zelxius on 14/03/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var login: PostViewModel
    
    var body: some View {
        Group{
//            if login.authenticated == 0 {
//                Login()
//            }else
            if login.authenticated <= 1 {
                SplashScreenView()
            }else
            if login.authenticated == 2{
                VStack{
                    Text("Incorrect Username&Password")
                    Button(action:{
                        login.authenticated = 0
                    }){
                        Text("Go Back")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
