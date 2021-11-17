//
//  Badge.swift
//  Landmarks
//
//  Created by Nathan Nguyen on 11/10/21.
//

import SwiftUI

struct Badge: View {
    @State private var visibility = false
    @GestureState private var longPress: Bool = false
    @GestureState private var offset: CGSize = .zero
    @State private var dragEnabled: Bool = false

    var body: some View {
        
        let longPressBeforeDrag = LongPressGesture(minimumDuration: 1.0)
            .onEnded( { _ in
                self.dragEnabled = true
            })
            .sequenced(before: DragGesture())
            .updating($offset) { value, state, transaction in switch value {
                case .first(true):
                    print("Long press in progress")
                case .second(true, let drag):
                    state = drag?.translation ?? .zero
                default: break
            }
        }
        .onEnded { value in
            self.dragEnabled = false
        }
        
        ZStack {
            
            if visibility {
                
                Spacer()
                BadgeShape()
                    .offset(offset)
                    .gesture(longPressBeforeDrag)
                Spacer()
                
              
                Toggle(isOn: $visibility.animation(.linear(duration: 1))){
                    Text("Toggle Appear")
                }
                .scaledToFit()
                .position(x: 200, y: 150)
                
               
                
                
            }
            
            if !visibility {
                VStack{
                
                Toggle(isOn: $visibility.animation(.linear(duration: 1))){
                    Text("Toggle Appear")
                }
                    
                    .padding()
                }
            }
            
            
            
            }
        
        
    }
}

struct Badge_Previews: PreviewProvider {
    static var previews: some View {
        Badge()
    }
}

struct BadgeShape: View{
    var badgeSymbols: some View {
        ForEach(0..<8) { index in
                    RotatedBadgeSymbol(
                        angle: .degrees(Double(index) / Double(8)) * 360.0
                    )
                }
                .opacity(0.5)
       }
    var body: some View{
        BadgeBackground()
        
        GeometryReader { geometry in
                    badgeSymbols
                        .scaleEffect(1.0 / 4.0, anchor: .top)
                        .position(x: geometry.size.width / 2.0, y: (3.0 / 4.0) * geometry.size.height)
        }
    }
}
