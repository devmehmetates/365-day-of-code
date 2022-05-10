//
//  ColorCyclingRectangle.swift
//  SwiftUIDrawing
//
//  Created by Mehmet Ateş on 10.05.2022.
//

import SwiftUI


struct TryCycle: View{
    @State private var colorCycle = 0.0
    @State private var anchor: UnitPoint = .top
    @State private var refleshScreen = false
    
    var body: some View {
        VStack {
           
            ColorCyclingRectangle(amount: colorCycle)
                .frame(width: 300, height: 300)
            
            Slider(value: $colorCycle)

        }.padding()
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    
    
    var body: some View {
        ZStack {
            ForEach(0..<100) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }.drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(100) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ColorCyclingRectangle_Previews: PreviewProvider {
    static var previews: some View {
        TryCycle()
    }
}
