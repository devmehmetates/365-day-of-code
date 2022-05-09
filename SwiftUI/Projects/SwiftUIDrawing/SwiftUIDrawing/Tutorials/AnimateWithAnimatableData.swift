//
//  AnimateWithAnimatableData.swift
//  SwiftUIDrawing
//
//  Created by Mehmet Ateş on 9.05.2022.
//

import SwiftUI

struct AnimateWithAnimatableData: View {
    @State private var insetAmount = 50.0
    
    var body: some View {
        Trapezoid(insetAmount: insetAmount)
            .frame(width: 200, height: 100)
            .onTapGesture {
                withAnimation {
                    insetAmount = Double.random(in: 1...160)
                }
            }

    }
}

struct AnimateWithAnimatableData_Previews: PreviewProvider {
    static var previews: some View {
        AnimateWithAnimatableData()
    }
}


struct Trapezoid: Shape {
    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue }
    }
    
    var insetAmount: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))
        
        return path
    }
}
