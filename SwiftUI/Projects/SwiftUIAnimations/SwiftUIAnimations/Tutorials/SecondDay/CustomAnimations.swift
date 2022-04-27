//
//  CustomAnimations.swift
//  SwiftUIAnimations
//
//  Created by Mehmet Ateş on 27.04.2022.
//

import SwiftUI

struct CustomAnimations: View {
    @State private var isShowingRed = false
    
    var body: some View {
        ZStack {
            if !isShowingRed{
                Rectangle()
                    .fill(.blue)
                    .frame(width: 200, height: 200)
                    .transition(.revertPivot)
            }
            
            
            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                isShowingRed.toggle()
            }
        }.navigationTitle("Custom Animations")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack{
                        Image(systemName: "info.circle")
                        Text("Tap content")
                    }.font(.callout)
                }
            }
    }
}

struct CustomAnimations_Previews: PreviewProvider {
    static var previews: some View {
        CustomAnimations()
    }
}


struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
    
    static var revertPivot: AnyTransition{
        .modifier(active: CornerRotateModifier(amount: 90, anchor: .topTrailing),
                  identity: CornerRotateModifier(amount: 0, anchor: .topTrailing)
        )
    }
}
