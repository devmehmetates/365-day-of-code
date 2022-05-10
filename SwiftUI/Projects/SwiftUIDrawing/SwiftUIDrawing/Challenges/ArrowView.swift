//
//  ArrowView.swift
//  SwiftUIDrawing
//
//  Created by Mehmet Ateş on 10.05.2022.
//

import SwiftUI

struct ArrowView: View {
    @State private var arrowType: Int = 0
    @State private var lineWidth: CGFloat = 3
    
    var body: some View {
        VStack{
            if arrowType == 1{
                Arrow2()
                    .stroke(.blue, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
            }else{
                Arrow()
                    .stroke(.red, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
            }
            
            Form{
                Picker("Arrow Type", selection: $arrowType) {
                    Button("Classic"){
                        arrowType = 0
                    }.tag(0)
                    Button("Modern"){
                        arrowType = 1
                    }.tag(1)
                }.pickerStyle(.segmented)
                
                Section("Line Width: \(lineWidth)"){
                    Slider(value: $lineWidth, in: 1...5)
                }
                
                Section("Animate line width"){
                    HStack{
                        ForEach(1..<6, id: \.self) { num in
                            Spacer()
                            Button("\(num)"){
                                withAnimation(.easeInOut) {
                                    lineWidth = CGFloat(num)
                                }
                            }.buttonStyle(BorderlessButtonStyle())
                            Spacer()
                        }
                    }
                }
            }
            
        }
    }
}

struct ArrowView_Previews: PreviewProvider {
    static var previews: some View {
        ArrowView()
    }
}

struct Arrow: Shape{
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let point = (UIScreen.main.bounds.width / 2)
        
        path.move(to: CGPoint(x: point, y: 0))
        path.addLine(to: CGPoint(x: point - 75, y: 100))
        path.addLine(to: CGPoint(x: point - 25, y: 100))
        path.addLine(to: CGPoint(x: point - 25, y: 300))
        path.addLine(to: CGPoint(x: point + 25, y: 300))
        path.addLine(to: CGPoint(x: point + 25, y: 100))
        path.addLine(to: CGPoint(x: point + 75, y: 100))
        path.addLine(to: CGPoint(x: (UIScreen.main.bounds.width / 2), y: 0))
        return path
    }
}

struct Arrow2: Shape{
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let point = (UIScreen.main.bounds.width / 2)
        
        path.move(to: CGPoint(x: point, y: 0))
        path.addLine(to: CGPoint(x: point - 75, y: 100))
        path.move(to: CGPoint(x: point, y: 0))
        path.addLine(to: CGPoint(x: point + 75, y: 100))
        path.move(to: CGPoint(x: point, y: 0))
        path.addLine(to: CGPoint(x: point, y: 300))
        return path
    }
}
