//
//  AnimationsAndGestures.swift
//  SwiftUIAnimations
//
//  Created by Mehmet Ateş on 27.04.2022.
//

import SwiftUI

struct AnimationsAndGestures: View {
    var body: some View {
        Form{
            NavigationLink {
                GradientDrag()
            } label: {
                Text("Gradient Drag")
            }
            NavigationLink {
                AnimatedTextEffect()
            } label: {
                Text("Text Effects")
            }
        }.navigationTitle("Animations With Gestures")
    }
}

struct AnimationsAndGestures_Previews: PreviewProvider {
    static var previews: some View {
        AnimationsAndGestures()
    }
}


struct GradientDrag: View{
    @State private var dragAmount = CGSize.zero
    
    var body: some View{
        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { dragAmount = $0.translation }
                    .onEnded { _ in
                        withAnimation(.spring()) {
                            dragAmount = .zero
                        }
                    }
            ).navigationTitle("Gradient Drag")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack{
                        Image(systemName: "info.circle")
                            
                        Text("Drag content!")
                    }.font(.callout)
                }
            }
    }
}

struct AnimatedTextEffect: View{
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    
    var body: some View{
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { num in
                Text(String(letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(enabled ? .blue : .red)
                    .offset(dragAmount)
                    .animation(.default.delay(Double(num) / 20), value: dragAmount)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { dragAmount = $0.translation }
                .onEnded { _ in
                    dragAmount = .zero
                    enabled.toggle()
                }
        ).navigationTitle("Animated Text Effect")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack{
                        Image(systemName: "info.circle")
                        Text("Drag content!")
                    }.font(.callout)
                }
            }
    }
}
