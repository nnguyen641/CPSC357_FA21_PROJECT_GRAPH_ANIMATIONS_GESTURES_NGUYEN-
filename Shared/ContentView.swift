//
//  ContentView.swift
//  Shared
//
//  Created by Nathan Nguyen on 11/9/21.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 1
    @State private var isSpinning: Bool = true
    @State private var visibility = false
    @GestureState private var offset: CGSize = .zero
    @State private var magnification: CGFloat = 1.0
    @GestureState private var longPress: Bool = false

    
    var body: some View {
        
        TabView(selection: $selection){
            
            
            Badge()
                
                .tabItem {
                Image(systemName: "1.circle")
                Text("Screen One")
                }
                .tag(1)
                
            
            CircleTemp()
                .tabItem {
                Image(systemName: "2.circle")
                Text("Screen Two")
                }
                .tag(2)
                .rotationEffect(.degrees(isSpinning ? 0 : 360))
            
                .animation(Animation.linear(duration: 1)
                            .repeatForever(autoreverses: false))
                .onAppear() {
                    self.isSpinning.toggle()
                }
            RectangleTemp()
                .tabItem {
                Image(systemName: "3.circle")
                Text("Screen Three")
                }
                .tag(3)
                .rotationEffect(.degrees(isSpinning ? 0 : 360))
            
                .animation(Animation.linear(duration: 10)
                            .repeatForever(autoreverses: false))
                .onAppear() {
                    self.isSpinning.toggle()
                }
        }.font(.largeTitle)
            // .tabViewStyle(PageTabViewStyle()) - swiping
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CircleTemp: View{
    let colors = Gradient(colors: [Color.red, Color.yellow, Color.blue, Color.green, Color.purple, Color.pink])
    
    var body:some View{
        Circle()
            .fill(AngularGradient(gradient:colors, center: .center))
    }
}

struct RectangleTemp: View{
    let colors = Gradient(colors: [Color.red, Color.yellow, Color.blue, Color.green, Color.purple, Color.pink])
    
    var body: some View{
        Rectangle()
                .fill(LinearGradient(gradient:colors, startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width:300, height:300)
    }
}
